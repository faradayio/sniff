require 'spec_helper'
require 'fileutils'

describe Sniff::Database do
  describe '#connect' do
    before :each do
      @db_path = File.join(File.dirname(__FILE__), '..', '..')
      Sniff::Database.init(@db_path)
      @sqlite_path = File.join(@db_path, 'db', 'emitter_data.sqlite3') 
    end
    after :each do
      FileUtils.rm_f(@sqlite_path)
    end
    it 'should create an sqlite database in the given directory' do
      File.exists?(@sqlite_path).should be_true
    end
    it 'should populate the database with data' do
      Airline.find_by_iata_code('AF').should_not be_nil
    end
  end
end

