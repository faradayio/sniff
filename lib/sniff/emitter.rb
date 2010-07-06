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
    end
    
    def parent_class
      Emitter
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
          if c.association
            if v.is_a?(Hash)
              # h[:origin_airport][:iata_code] => 'MIA'
              attr_name, attr_value = v.to_a.flatten[0, 2]
              resolved_params[k] = c.association.klass.send "find_by_#{attr_name}", attr_value
            else
              # h[:origin_airport] => 'MIA'
              resolved_params[k] = c.association.klass.send "find_by_#{k}", v
            end
          else
            resolved_params[k] = v
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

