require 'spec_helper'

describe Sniff::Database do
  describe '#connect' do
    let(:dirigible_path) { File.expand_path '../../fixtures/dirigible', File.dirname(__FILE__) }
    
    before :all do
      $:.unshift File.join(dirigible_path, 'lib')
      require File.join('dirigible')
      DataMiner.logger = Logger.new $stdout
    end

    it 'should load the air domain' do
      Sniff.init(dirigible_path, :earth => :air, :apply_schemas => true)
      Airport.count.should == 0 # we don't have fixtures for this here
      expect { ZipCode.count }.should raise_error
      expect { AutomobileFuelType.count }.should raise_error
    end
    it 'should load data for all domains' do
      puts dirigible_path + '/lib/test_support/db/fixtures'
      Sniff.init(dirigible_path, :earth => :all, :apply_schemas => true,
                 :fixtures_path => dirigible_path + '/lib/test_support/db/fixtures')
      PetroleumAdministrationForDefenseDistrict.count.should == 7
    end
    it 'should load a schema for the emitter record' do
      Sniff.init(dirigible_path, :apply_schemas => true)
      require File.join(dirigible_path, 'features', 'support', 'dirigible_record')
      DirigibleRecord.table_exists?.should be_true
    end
  end
end

