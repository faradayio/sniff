require 'spec_helper'

describe Sniff::Database do
  describe '#connect' do
    let(:dirigible_path) { File.expand_path '../../fixtures/dirigible', __FILE__ }
    
    before :all do
      $:.unshift File.join(dirigible_path, 'lib')
      require 'dirigible'
      require File.join(dirigible_path, 'features', 'support', 'dirigible_record')
      DataMiner.logger = Logger.new $stdout
    end

    it 'should load the air domain' do
      Sniff::Database.init(:air, :apply_schemas => true, :root => dirigible_path)
      Airport.count.should == 0 # we don't have fixtures for this here
      expect { Industry.count }.should raise_error
      expect { AutomobileFuelType.count }.should raise_error
    end
    it 'should load data for all domains' do
      puts dirigible_path + '/lib/test_support/db/fixtures'
      Sniff::Database.init(:all, :apply_schemas => true,
                 :root => dirigible_path,
                 :fixtures_path => dirigible_path + '/lib/test_support/db/fixtures')
      PetroleumAdministrationForDefenseDistrict.count.should == 7
    end
    it 'should load a schema for the emitter record' do
      Sniff::Database.init(:none, :apply_schemas => true, :root => dirigible_path)
      DirigibleRecord.table_exists?.should be_true
    end
  end
end

