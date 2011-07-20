require 'data_miner'
require 'force_schema'
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
  # * :earth is the list of domains Earth.init should load (default: none)
  # * :load_data determines whether fixture data is loaded (default: true)
  # * :logger is a Logger log device used by Sniff and ActiveRecord (default: nil)
  #           logger: nil = no log, string = file path, STDOUT for terminal
  # * :fixtures_path is the path to your gem's fixtures (default: local_root/lib/db/fixtures)
  def init(local_root, options = {})
    options[:earth] ||= :none

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

require 'earth'

$:.unshift File.dirname(__FILE__)
require 'sniff/database'
require 'sniff/emitter'
