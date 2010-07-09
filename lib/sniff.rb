module Sniff
  extend self

  def root 
    File.join(File.dirname(__FILE__), '..')
  end

  def init(local_root, options = {})
    require 'active_record'
    require 'sqlite3'

    load_plugins

    Sniff::Database.init local_root, options
  end

  def load_plugins
    Dir[File.join(Sniff.root, 'vendor', '**', 'init.rb')].each do |pluginit|
      $:.unshift File.join(File.dirname(pluginit), 'lib')
      load pluginit
    end
  end
end

require 'characterizable'
$:.unshift File.dirname(__FILE__)
require 'sniff/active_record_ext'
require 'sniff/database'
require 'sniff/emitter'
require 'sniff/conversions_ext'
require 'sniff/timeframe'
