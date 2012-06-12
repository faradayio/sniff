require 'data_miner'
require 'active_record_inline_schema'
require 'sniff/leap_ext'
require 'logger'

module Sniff
  # Sniff's root directory (the gem's location on the filesystem)
  def Sniff.root 
    File.join(File.dirname(__FILE__), '..')
  end

  # Get a path relative to sniff's root
  def Sniff.path(*rest)
    File.join(root, *rest)
  end

  def Sniff.logger
    @logger ||= Logger.new nil
  end
  def Sniff.logger=(val)
    @logger = val
  end

  # Prepares the environment for running tests against Earth data and emitter 
  # gems.
  #
  # Can take a list of Earth domains (see Earth.init) and/or a set of options.
  #
  # options: 
  # * :root is the path to the SUT (which has support files in the expected places)
  # * :earth is the list of domains Earth.init should load (default: none)
  # * :load_data determines whether fixture data is loaded (default: true)
  # * :logger is a Logger log device used by Sniff and ActiveRecord (default: nil)
  #           logger: nil = no log, string = file path, STDOUT for terminal
  # * :fixtures_path is the path to your gem's fixtures (default: local_root/lib/db/fixtures)
  #
  # Examples:
  # 
  #     Sniff.init :all, :logger => STDOUT
  #
  #     Sniff.init :logger => StringIO.new
  def Sniff.init(*args)
    options = args.extract_options!
    domains = args || [:none]

    logger = options.delete(:logger) || ENV['LOGGER']
    Sniff.logger = Logger.new logger
    DataMiner.logger = Sniff.logger

    Sniff::Database.init *domains, options

    if options[:cucumber]
      cukes = Dir.glob File.join(File.dirname(__FILE__), 'test_support', 'cucumber', '**', '*.rb')
      cukes.each { |support_file| require support_file }
    end
  end
end

require 'earth'

$:.unshift File.dirname(__FILE__)
require 'sniff/database'
