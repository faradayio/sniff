require 'spec_helper'

describe Sniff do
  describe '.init' do
    it 'creates a test environment' do
      expect do
        Sniff.init :air
      end.not_to raise_error
    end
  end

  describe '.path' do
    it 'returns a path relative to sniff root' do
      Sniff.stub!(:root).and_return File.join('/path','to','my','gems','sniff')
      Sniff.path('lib','sniff','stuff.rb').split(/[\/\\]/).
        should == ['', 'path','to','my','gems','sniff','lib','sniff','stuff.rb']
    end
  end
end

