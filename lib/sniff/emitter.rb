require 'fast_timestamp'
require 'common_name'

module Sniff
  module Emitter
    def self.included(target)
      target.instance_eval do
        extend ClassMethods
        include CommonName
      end
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
        instance = new
        associations = reflect_on_all_associations
        params.each do |k, v|
          next if v.blank?
          c = characteristics[k.to_sym]
          next if c.nil?
          if associations.map(&:name).include?(c.name.to_sym)
            association = associations.find { |a| a.name == c.name.to_sym }
            klass = association.options[:class_name] || association.name.to_s.pluralize.classify
            klass = klass.constantize
            if v.is_a?(Hash)
              # h[:origin_airport][:iata_code] => 'MIA'
              attr_name, attr_value = v.to_a.flatten[0, 2]
              resolved_params[k] = klass.send "find_by_#{attr_name}", attr_value
            else
              # h[:origin_airport] => 'MIA'
              resolved_params[k] = klass.send "find_by_#{k}", v
            end
          else
            resolved_params[k] = v
          end
        end
        new resolved_params
      end

      def add_implicit_characteristics
        decisions[:emission].committees.map(&:name).reject { |c| characteristics.keys.unshift(:emission).include? c }.each do |c|
          characterize { has c }
        end
      end
      
      def _common_name
        name.underscore
      end

      def pattern?
        common_name.ends_with? 'pattern'
      end
    end
  end
end

