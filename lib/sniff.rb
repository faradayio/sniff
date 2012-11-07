require 'active_record_inline_schema'
require 'data_miner'
require 'earth'
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

  def Sniff.init(local_root, options = {})
    sniff = new local_root, options
    sniff.connect
    sniff.migrate!
    sniff.seed!
    sniff
  end

  attr_accessor :root, :options, :test_support_path, :fixtures_path,
    :logger, :project

  # Prepares the environment for running tests against Earth data and emitter 
  # gems.
  #
  # local_root: Root directory of the emitter gem to be tested (path to the repo)
  #
  # options: 
  # * :logger is a Logger log device used by Sniff and ActiveRecord (default: nil)
  #           logger: nil = no log, string = file path, STDOUT for terminal
  # * :fixtures_path is the path to your gem's fixtures (default: local_root/lib/db/fixtures)
  # * :cucumber tells Sniff to load cucumber test support files provided by the emitter in <emitter_root>/test_support/cucumber (default: false)
  # * :project is the current project (e.g. 'flight'). Default is guessed from CWD
  def initialize(local_root, options = {})
    self.root = local_root
    self.project = options[:project] || File.basename(File.expand_path(local_root))
    self.options = options.symbolize_keys
    self.test_support_path = File.join(root, 'features', 'support')
    self.fixtures_path = options[:fixtures_path]

    ENV['DATABASE_URL'] ||= "mysql2://root:password@localhost/test_#{project}"

    load_supporting_libs

    logger = self.options[:logger] || ENV['LOGGER']
    Sniff.logger ||= Logger.new logger
    DataMiner.logger = Sniff.logger
    DataMiner.unit_converter = :conversions

    init_cucumber if self.options[:cucumber]
  end

  def init_cucumber
    require 'cucumber'
    require 'cucumber/formatter/unicode' # Remove this line if you don't want Cucumber Unicode support
    cukes = Dir.glob File.join(File.dirname(__FILE__), 'test_support', 'cucumber', '**', '*.rb')
    cukes.each { |support_file| require support_file }
  end

  def log(str)
    Sniff.logger.info str
  end

  def fixtures_path
    @fixtures_path ||= File.join(test_support_path, 'db', 'fixtures')
  end

  # Connect to the database and set up an ActiveRecord logger
  def connect
    ActiveRecord::Base.logger = Sniff.logger
    Earth.connect
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
    require project

    $:.unshift File.join(root, 'lib')
    Dir[File.join(root, 'lib', 'test_support', '*.rb')].each do |lib|
      log "Loading #{lib}"
      require lib
    end
  end
end
