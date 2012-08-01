require 'spec_helper'
require 'earth'

describe Sniff::Database do
  describe '#connect' do
    let(:dirigible_path) { File.expand_path '../../fixtures/dirigible', __FILE__ }
    
    before :all do
      $:.unshift File.join(dirigible_path, 'lib')
      require File.join('dirigible')
      DataMiner.logger = Logger.new $stdout
    end
    it 'loads fixtures' do
      require 'earth/locality/petroleum_administration_for_defense_district'

      Sniff.init(dirigible_path, :fixtures_path => dirigible_path + '/lib/test_support/db/fixtures')
      PetroleumAdministrationForDefenseDistrict.count.should == 7
    end
    it 'loads a schema for the emitter record' do
      Sniff.init(dirigible_path)
      require File.join(dirigible_path, 'features', 'support', 'dirigible_record')
      DirigibleRecord.table_exists?.should be_true
    end
  end
end

