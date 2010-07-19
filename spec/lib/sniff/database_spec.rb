require 'spec_helper'
require 'fileutils'

describe Sniff::Database do
  describe '#connect' do
    before :each do
      @db_path = File.join(File.dirname(__FILE__), '..', '..', '..')
    end
    it 'should load the air domain' do
      Sniff.init(@db_path, :earth => :air, :apply_schemas => true)
      Airport.count.should == 0 # we don't have fixtures for this here
      ZipCode.count.should > 0
      expect { AutomobileFuelType }.should raise_error
    end
    it 'should load data for all domains' do
      Sniff.init(@db_path, :earth => :all, :apply_schemas => true)
      ZipCode.count.should > 0
    end
  end
end

