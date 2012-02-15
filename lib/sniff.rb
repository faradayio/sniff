require 'configuration'
require 'data_miner'
require 'earth'
require 'mini_record'
require 'sniff/leap_ext'
require 'logger'

require 'sniff/database'

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

  # Configures Sniff with various options
  def configure(root, &blk)
    @settings = Configuration.for('sniff', default_settings(root), &blk)
  end

  def settings; @settings; end

  def default_settings(root)
    Configuration.for('default') do
      root root
      earth_domains :none
      earth_options nil
      logger Logger.new(nil)
      data_miner_logger Logger.new(nil)
      database_enabled true
      database_logger Logger.new(nil)
      database_support_path File.join(root, 'features', 'support')
      database_fixtures_enabled true
      database_fixtures_path File.join(root, 'features', 'support', 'db', 'fixtures')
      database_connection :adapter => 'sqlite3', :database => ':memory:'
      cucumber nil
    end
  end

  # Prepares the environment for running tests against Earth data and emitter 
  # gems.
  #
  # options: 
  # * :earth is the list of domains Earth.init should load (default: none)
  # * :load_data determines whether fixture data is loaded (default: true)
  # * :logger is a Logger log device used by Sniff and ActiveRecord (default: nil)
  #           logger: nil = no log, string = file path, STDOUT for terminal
  # * :fixtures_path is the path to your gem's fixtures (default: local_root/lib/db/fixtures)
  def init(root, &blk)
    configure(root, &blk)
    init_loggers
    init_database
    init_earth
    init_cucumber
    load_supporting_libs
  end

  def init_loggers
    Sniff.logger = settings.logger
    DataMiner.logger = settings.data_miner_logger
  end

  def init_earth
    domains = settings.earth_domains
    domains = [domains] unless domains.is_a? Array
    args = domains
    args << settings.earth_options if settings.earth_options
    Earth.init *args
  end

  def init_database
    Sniff::Database.init settings if settings.database_enabled
  end

  def init_cucumber
    if settings.cucumber
      require 'cucumber'
      cukes = Dir.glob File.join(File.dirname(__FILE__), %w{test_support cucumber step_definitions ** *.rb})
      cukes.each { |support_file| require support_file }
      require_relative './test_support/cucumber/support/activity'
      require_relative './test_support/cucumber/support/values'
      settings.cucumber.World(Sniff::Activity, Sniff::Values)
    end
  end

  def load_supporting_libs
    $:.unshift File.join(settings.root, 'lib')
    Dir[File.join(settings.root, 'lib', 'test_support', '*.rb')].each do |lib|
      Sniff.logger.info "Loading #{lib}"
      require lib
    end
  end
end
