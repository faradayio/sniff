require 'spec_helper'
require 'fileutils'

describe Sniff::Database do
  describe '#connect' do
    before :all do
      @db_path = File.join(File.dirname(__FILE__), '..', '..', '..')
      Sniff.init(@db_path)
      @sqlite_path = File.join(@db_path, 'db', 'emitter_data.sqlite3') 
    end
    after :all do
      FileUtils.rm_f(@sqlite_path)
    end
    it 'should create an sqlite database in the given directory' do
      File.exists?(@sqlite_path).should be_true
    end
    it 'should load data' do
      ZipCode.count.should > 0
    end
  end
end

