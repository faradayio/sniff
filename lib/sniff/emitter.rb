require 'summary_judgement'
require 'fast_timestamp'
require 'common_name'
require 'falls_back_on'

module Sniff
  module Emitter
    def self.included(target)
      target.send :extend, ClassMethods
      target.send :extend, SummaryJudgement
      target.send :extend, FastTimestamp
      target.send :include, Characterizable
#    set_table_name common_plural
    end

    def external_for(name, options = {})
      c = self.class.characteristics[name]
      if options.has_key?(:value)
        value = options[:value]
      elsif characteristics[name]
        value = characteristics[name]
      elsif committee_reports.has_key?(name)
        value = committee_reports[name]
      else
        return ''
      end
      options[:show_unit] = true unless options.has_key?(:show_unit)
      adjective = options[:adjective] === true
      external = value
      begin
        measures = c.measures
      rescue
        raise $!, "died trying to ask #{c} for measures (related to #{name})"
      end
      m_o = c.measurement_options
      case value
      when ActiveRecord::Relation
        external = value.inspect # fixme
      when Numeric
        if measures == :percentage
          external *= 100.0
        else
          external = external.convert(m_o[:internal], m_o[:external]) if m_o.has_key?(:internal) and m_o.has_key?(:external)
        end
        if measures == :percentage
          external = external.round
        elsif measures == :cost
          external = '%0.2f' % external
          external.gsub!('.00', '')
        elsif !external.is_a?(Integer)
          if p = c.precision
            external = (p == 0) ? external.round : external.round_with_precision(p)
          else
            external = external.adaptive_round
          end
        end
        if options[:show_unit]
          external = "#{external}%" if measures == :percentage
          external = "$#{external}" if measures == :cost
          if m_o.has_key?(:external) and measures != :cost
            unit = m_o[:external].to_s.humanize.downcase
            unit = unit.singularize if adjective
          else
            unit = nil
          end
          external = [ external, unit ].compact.join(' ')
        end
      when ActiveRecord::Base
        external = external.name.andand.titleize
      when Date, Time
        if name.to_s.starts_with?('time')
          external = external.strftime('%I %p').gsub /\A0/, ''
        else
          external = external.to_formatted_s :archive
        end
      when TrueClass
        external = 'Yes'
      when FalseClass
        external = 'No'
      when Hash
        if value.values.all? { |v| (0..1).include? v }
          multiplier = 100
          suffix = '%'
          remove = '_share'
        else
          multiplier = 1
          suffix = ''
          remove = 'foobar'
        end
        external = value.collect { |v| "#{(v[1] * multiplier).round}#{suffix} #{v[0].to_s.gsub(remove, '').humanize.downcase}"}.join(', ')
      when Timeframe
        external = value.inspect
      else
        raise "#{value.inspect} was a #{value.class}"
      end
      external
    end
    
    def parent_class
      Emitter
    end
          
    # Returns our confidence level in a given #emission value. Stubbed out for now.
    def confidence_in_emission_value
      #FIXME this is way, way off
      50.0 + (100.0 * characteristics.effective.length / (characteristics.length + 1)) / 2.0
    end
    
    def visible_effective_characteristics
      characteristics.effective.reject { |_, c| c.hidden? }
    end
      
    def retired?
      has_attribute?(:retirement) and retirement
    end
    
    def pattern?
      self.class.pattern?
    end
    
    module ClassMethods
      def from_params_hash(params = Hash.new)
        resolved_params = Hash.new
        params.each do |k, v|
          next if v.blank?
          c = characteristics[k.to_sym]
          next if c.nil?
          puts "k: #{k.inspect} c #{c.inspect}"
          unless c.association
            resolved_params[k] = v
          else
            if v.is_a?(Hash)
              # h[:origin_airport][:iata_code] => 'MIA'
              attr_name, attr_value = v.to_a.flatten[0, 2]
              resolved_params[k] = c.association.klass.send "find_by_#{attr_name}", attr_value
            else
              # h[:origin_airport] => 'MIA'
              resolved_params[k] = c.association.klass.loose_find v.to_s
            end
          end
        end
        new resolved_params
      end
      
      def pattern?
        common_name.ends_with? 'pattern'
      end
    end
  end
end

