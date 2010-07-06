module Sniff
  extend self

  def root 
    File.join(File.dirname(__FILE__), '..')
  end
end

require 'characterizable'
$:.unshift File.dirname(__FILE__)
require 'sniff/active_record_ext'
require 'sniff/database'
require 'sniff/emitter'
require 'sniff/conversions_ext'
