require 'data_miner'
require 'active_record_inline_schema'
require 'sniff/leap_ext'
require 'logger'

module Sniff
  extend self

  # Sniff's root directory (the gem's location on the filesystem)
  def root 
    File.join(File.dirname(__FILE__), '..')
  end

  # Get a path relative to sniff's root
  def path(*rest)
    File.join(root, *rest)
  end

  def logger
    @logger ||= Logger.new nil
  end
  def logger=(val)
    @logger = val
  end

  # Prepares the environment for running tests against Earth data and emitter 
  # gems.
  #
  # local_root: Root directory of the emitter gem to be tested (path to the repo)
  #
  # options: 
  # * :logger is a Logger log device used by Sniff and ActiveRecord (default: nil)
  #           logger: nil = no log, string = file path, STDOUT for terminal
  # * :fixtures_path is the path to your gem's fixtures (default: local_root/lib/db/fixtures)
  # * :reset_schemas tells earth to recreate tables for each model (default: false)
  # * :cucumber tells Sniff to load cucumber test support files provided by the emitter in <emitter_root>/test_support/cucumber (default: false)
  def init(local_root, options = {})
    logger = options.delete(:logger) || ENV['LOGGER']
    Sniff.logger = Logger.new logger
    DataMiner.logger = Sniff.logger

    Sniff::Database.init local_root, options

    if options[:cucumber]
      cukes = Dir.glob File.join(File.dirname(__FILE__), 'test_support', 'cucumber', '**', '*.rb')
      cukes.each { |support_file| require support_file }
    end
  end
end

$:.unshift File.dirname(__FILE__)
require 'sniff/database'
