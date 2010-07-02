module Sniff
  ROOT = File.join(File.dirname(__FILE__), '..')
end

TAPS_SERVER = 'http://example.com/data_for_me' # we will never actually be
                                               # pulling data from a remote server

$:.unshift File.dirname(__FILE__)
require 'sniff/database'
