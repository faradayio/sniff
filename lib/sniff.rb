module Sniff
  extend self

  def root 
    File.join(File.dirname(__FILE__), '..')
  end
end

TAPS_SERVER = 'http://example.com/data_for_me' # we will never actually be
                                               # pulling data from a remote server

require 'characterizable'
$:.unshift File.dirname(__FILE__)
require 'sniff/active_record_ext'
require 'sniff/database'
require 'sniff/emitter'
