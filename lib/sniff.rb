module Sniff
  extend self

  def root 
    File.join(File.dirname(__FILE__), '..')
  end

  def init(local_root, options = {})
    options[:earth] ||= :none
    require 'sqlite3'

    Sniff::Database.init local_root, options
  end
end

require 'earth'
require 'characterizable'
require 'timeframe'

$:.unshift File.dirname(__FILE__)
require 'sniff/database'
require 'sniff/emitter'
