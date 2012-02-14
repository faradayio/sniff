require 'spec_helper'
require 'test_support/cucumber/support/values'

include Sniff::Values

describe Sniff::Values do
  describe '#coerce_value' do
    it 'should leave a nil value alone' do
      coerce_value(nil).should be_nil
    end
    it 'should parse "false" into a boolean' do
      coerce_value('false').should be_false
    end
    it 'should parse "true" into a boolean' do
      coerce_value('true').should be_true
    end
    it 'should parse a float' do
      coerce_value('2.3').should == 2.3
    end
    it 'should parse a zero-prefixed float' do
      coerce_value('2.0').should == 2.0
    end
    it 'should parse a range' do
      coerce_value('12..42').should == (12..42)
    end
    it 'should parse an integer' do
      coerce_value('2').should == 2
    end
    it 'should parse a date' do
      coerce_value('today').should be_an_instance_of(Time)
      coerce_value('2010-01-20').should be_an_instance_of(Time)
      coerce_value('2010-01-20 13:00:00').should be_an_instance_of(Time)
      coerce_value('2 days from now').should be_an_instance_of(Time)
    end
    it 'should leave regular strings alone' do
      coerce_value('sandwich').should == 'sandwich'
      coerce_value('UA').should == 'UA'
    end
  end
end

