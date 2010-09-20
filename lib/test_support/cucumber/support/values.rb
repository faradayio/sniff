require 'date'
require 'active_support'
require 'chronic'

module CucumberValueParser
  def coerce_value(value)
    # what is this, PHP?
    if value.blank?
      nil
    elsif value == 'true'
      true
    elsif value == 'false'
      false
    elsif value =~ /\d+\.\d+/
      value.to_f
    elsif value =~ /^\d+$/
      value.to_i
    elsif value.is_a?(String) and date = Chronic.parse(value)
      date
    else
      value
    end
  end

  def compare_values(a, b)
    if b.blank?
      a.should be_blank
    elsif a.is_a? Time
      b = Chronic.parse b unless b.is_a?(Time)
      a.should == b
    elsif a.is_a? Date 
      b = Date.parse b unless b.is_a?(Date)
      a.should == b
    elsif b =~ /\d+\.\d+/
      b = b.to_f
      a.to_f.should be_close(b, 0.00001)
    elsif b =~ /^\d+$/
      b = b.to_i
      a.to_i.should == b
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
    elsif b =~ /\d+\.\d+/
      (a.to_f - b.to_f).abs <= 0.00001
    elsif b =~ /^\d+$/
      a.to_i == b.to_i
    else
      a == b
    end
  end
end

include CucumberValueParser
