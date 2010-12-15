require 'spec_helper'
require 'fileutils'

describe Sniff::Database do
  describe '#connect' do
    let(:dirigible_path) { File.expand_path '../../fixtures/dirigible', File.dirname(__FILE__) }
    
    before :all do
      $:.unshift File.join(dirigible_path, 'lib')
      require File.join('dirigible')
    end

    it 'should load the air domain' do
      Sniff.init(dirigible_path, :earth => :air, :apply_schemas => true)
      Airport.count.should == 0 # we don't have fixtures for this here
      ZipCode.count.should > 0
      expect { AutomobileFuelType }.should raise_error
    end
    it 'should load data for all domains' do
      Sniff.init(dirigible_path, :earth => :all, :apply_schemas => true)
      ZipCode.count.should > 0
    end
    it 'should load a schema for the emitter record' do
      Sniff.init(dirigible_path, :apply_schemas => true)
      require File.join(dirigible_path, 'lib', 'test_support', 'dirigible_record')
      DirigibleRecord.table_exists?.should be_true
    end
    it 'should load data for PADD' do
      Sniff.init(dirigible_path, :earth => :locality, :apply_schemas => true)
      PetroleumAdministrationForDefenseDistrict.all.count.should == 7
    end
  end
end

