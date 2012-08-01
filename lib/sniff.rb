require 'data_miner'
require 'active_record_inline_schema'
require 'logger'

require 'sniff/fixture'
require 'sniff/leap_ext'

class Sniff
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

  attr_accessor :root, :options, :test_support_path, :fixtures_path, :logger

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
  def initialize(local_root, options = {})
    self.root = local_root
    self.options = options.symbolize_keys
    self.test_support_path = File.join(root, 'features', 'support')
    self.fixtures_path = options[:fixtures_path]
    load_supporting_libs

    logger = self.options[:logger] || ENV['LOGGER']
    Sniff.logger ||= Logger.new logger
    DataMiner.logger = Sniff.logger

    if self.options[:cucumber]
      cukes = Dir.glob File.join(File.dirname(__FILE__), 'test_support', 'cucumber', '**', '*.rb')
      cukes.each { |support_file| require support_file }
    end
  end

  def log(str)
    Sniff.logger.info str
  end

  def fixtures_path
    @fixtures_path ||= File.join(test_support_path, 'db', 'fixtures')
  end

  # Connect to the database and set up an ActiveRecord logger
  def connect
    options[:adapter] ||= options[:db_adapter] || 'sqlite3'
    options[:database] ||= options[:db_name] || 'db/test.sqlite3'
    ActiveRecord::Base.logger = Sniff.logger
    ActiveRecord::Base.establish_connection options
  end

  def emitter_class
    return @emitter_class unless @emitter_class.nil?
    record_class_path = Dir.glob(File.join(test_support_path, '*_record.rb')).first
    if record_class_path
      require record_class_path
      record_class = File.read(record_class_path)
      klass = record_class.scan(/class ([^\s]*Record)/).flatten.first
      @emitter_class = klass.constantize
    end
  end

  def migrate!
    emitter_class.auto_upgrade! if emitter_class
  end

  def seed!
    Fixture.load_fixtures fixtures_path
  end

  def load_supporting_libs
    $:.unshift File.join(root, 'lib')
    Dir[File.join(root, 'lib', 'test_support', '*.rb')].each do |lib|
      log "Loading #{lib}"
      require lib
    end
  end
end
