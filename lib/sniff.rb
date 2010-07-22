module Sniff
  extend self

  def root 
    File.join(File.dirname(__FILE__), '..')
  end

  def init(local_root, options = {})
    options[:earth] ||= :none

    Sniff::Database.init local_root, options

    if defined?(Cucumber)
      step_definitions = Dir.glob File.join(File.dirname(__FILE__), 'test_support', 'step_definitions', '**', '*.rb')
      step_definitions.each { |definition| require definition }
    end
  end
end

require 'earth'

$:.unshift File.dirname(__FILE__)
require 'sniff/database'
require 'sniff/emitter'
