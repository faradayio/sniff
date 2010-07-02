require 'spec_helper'
require 'fileutils'

describe Sniff::Database do
  describe '#connect' do
    it 'should create an sqlite database in the given directory' do
      db_path = File.join(File.dirname(__FILE__), '..', '..')
      Sniff::Database.init(db_path)
      sqlite_path = File.join(db_path, 'db', 'emitter_data.sqlite3') 
      File.exists?(sqlite_path).should be_true
      FileUtils.rm_f(sqlite_path)
    end
  end
end

