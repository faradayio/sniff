require 'spec_helper'

require 'earth'
require 'earth/locality/petroleum_administration_for_defense_district'

describe Sniff do
  let(:dirigible_path) { File.expand_path '../fixtures/dirigible', __FILE__ }
  let(:sniff) do
    sniff = Sniff.new(dirigible_path, :project => 'sniff')
    sniff.connect
    sniff
  end
    
  before :all do
    $:.unshift File.join(dirigible_path, 'lib')
    require File.join('dirigible')
    DataMiner.logger = Logger.new $stdout
  end

  describe '.path' do
    it 'returns a path relative to sniff root' do
      Sniff.stub!(:root).and_return File.join('/path','to','my','gems','sniff')
      Sniff.path('lib','sniff','stuff.rb').split(/[\/\\]/).
        should == ['', 'path','to','my','gems','sniff','lib','sniff','stuff.rb']
    end
  end
  describe '#migrate!' do
    it 'loads a schema for the emitter record' do
      sniff.migrate!
      require File.join(dirigible_path, 'features', 'support', 'dirigible_record')
      DirigibleRecord.table_exists?.should be_true
    end
  end
  describe '#seed!' do
    it 'loads fixtures' do
      sniff.seed!
      PetroleumAdministrationForDefenseDistrict.count.should == 7
    end
  end
end

