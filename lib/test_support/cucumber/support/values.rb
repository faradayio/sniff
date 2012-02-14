require 'date'
require 'active_support'
require 'chronic'

module Sniff
  module Values
    def coerce_value(value)
      # what is this, PHP?
      if value.blank?
        nil
      elsif value == 'true'
        true
      elsif value == 'false'
        false
      elsif value =~ /\d+.*,.*\d/ # ???
        value
      elsif value =~ /^\d+\.\d+$/ # float
        value.to_f
      elsif value =~ /^\d+(\.\d+)?\.\.\d+(\.\d+)?$/ # range
        (value.split('..')[0].to_i)..(value.split('..')[1].to_i)
      elsif value =~ /^0+$/ # all zeros => 0
        0
      elsif value =~ /^0/ # zero preceding stuff => the input as a string
        value
      elsif value =~ /^\d+$/ # integer
        value.to_i
      elsif value =~ /Address:/
        value.sub(/Address:\s*/,'')
      elsif value.is_a?(String) and date = Chronic.parse(value)
        date
      else
        value
      end
    end

    def compare_values(a, b)
      if b.blank?
        a.should be_blank
      elsif a.is_a?(Float)
        a.should be_within(0.00001).of(b)
      elsif a.is_a? Date
        a.strftime('%Y-%m-%d').should == b.strftime('%Y-%m-%d')
      elsif a.is_a? Time
        a.strftime('%Y-%m-%d %H:%M:%s').should == b.strftime('%Y-%m-%d %H:%M:%s')
      else
        a.should == b
      end
    end

    def equality?(a, b)
      if b.blank?
        a.blank?
      elsif a.is_a? Date or a.is_a? Time
        b = Date.parse b
        a == b
      elsif b =~ /\d+.*,.*\d/
        a == b
      elsif b =~ /\d+\.\d+/
        (a.to_f - b.to_f).abs <= 0.00001
      elsif b =~ /^0/
        a == b
      elsif b =~ /^\d+$/
        a.to_i == b.to_i
      else
        a == b
      end
    end
  end
end
