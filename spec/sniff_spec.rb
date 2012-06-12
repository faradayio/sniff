require 'spec_helper'

describe Sniff do
  describe '.path' do
    it 'returns a path relative to sniff root' do
      Sniff.stub!(:root).and_return File.join('/path','to','my','gems','sniff')
      Sniff.path('lib','sniff','stuff.rb').split(/[\/\\]/).
        should == ['', 'path','to','my','gems','sniff','lib','sniff','stuff.rb']
    end
  end
end

