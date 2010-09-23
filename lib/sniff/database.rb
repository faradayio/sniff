require 'active_support'
require 'fileutils'
require 'logger'
require 'sqlite3'

module Sniff
  class Database
    class << self
      # Initialize a database used for testing emitter gems
      #
      # local_root: Root directory of the emitter gem to be tested (path to the repo)
      # options: 
      # * :earth is the list of domains Earth.init should load (default: none)
      # * :load_data determines whether fixture data is loaded (default: true)
      # * :sqllogdev is a Logger log device used by ActiveRecord (default: nil)
      # * :fixtures_path is the path to your gem's fixtures (default: local_root/lib/db/fixtures)
      # * :logdev is a Logger log device used for general logging (default: nil)
      def init(local_root, options = {})
        db_init options
        earth_init(options[:earth])

        environments = []
        environments << init_environment(local_root, options)

        unless local_root == Sniff.root
          environments << init_environment(Sniff.root)
        end
        
        environments.each { |e| e.populate_fixtures }
      end

    private
      def init_environment(root, options = {})
        db = new root, options
        db.init
        db
      end

      # Connect to the database and set up an ActiveRecord logger
      def db_init(options)
        ActiveRecord::Base.logger = Logger.new options[:sqllogdev]
        ActiveRecord::Base.establish_connection :adapter => 'sqlite3',
          :database => ':memory:'
      end

      # Initialize Earth, tell it to load schemas defined by each domain model's
      # data_miner definition
      def earth_init(domains)
        domains ||= :none
        domains = [domains] unless domains.is_a? Array
        args = domains
        args << {:apply_schemas => true}

        Earth.init *args
      end
    end

    attr_accessor :root, :lib_path, :fixtures_path,
      :load_data, :fixtures, :logger

    def initialize(root, options)
      self.root = root
      self.lib_path = File.join(root, 'lib', 'test_support')
      self.load_data = options[:load_data]
      self.fixtures_path = options[:fixtures_path]
      self.logger = Logger.new options[:logdev]
    end

    def log(str)
      logger.info str
    end

    def load_data?
      @load_data = true if @load_data.nil?
      @load_data
    end

    def fixtures_path
      @fixtures_path ||= File.join(lib_path, 'db', 'fixtures')
    end

    def fixtures
      @fixtures ||= []
    end

    def init
      load_supporting_libs
      create_emitter_table
      read_fixtures if load_data?
    end

    def emitter_class
      return @emitter_class unless @emitter_class.nil?
      record_class_file = Dir.glob(File.join(root, 'lib', 'test_support', '*_record.rb')).first
      if record_class_file
        record_class = File.read(record_class_file)
        klass = record_class.scan(/class ([^\s]*Record)/).flatten.first
        @emitter_class = klass.constantize
      end
    end

    def create_emitter_table
      emitter_class.execute_schema if emitter_class
    end

    def read_fixtures
      require 'active_record/fixtures'
      log "Reading fixtures from #{fixtures_path}/**/*.{yml,csv}"

      Dir["#{fixtures_path}/**/*.{yml,csv}"].each do |fixture_file|
        fixtures << fixture_file
      end
    end

    def populate_fixtures
      fixtures.each do |fixture_file|
        klass = File.basename(fixture_file, '.csv').
          camelize.singularize
        pluralized_klass = klass.pluralize
        klass = klass.pluralize unless Object.const_defined?(klass)
        if Object.const_defined?(klass) and klass.constantize.table_exists?
          log "Loading fixture #{fixture_file}"
          Fixtures.create_fixtures(fixtures_path, fixture_file[(fixtures_path.size + 1)..-5])
        end
      end
    end

    def load_supporting_libs
      $:.unshift File.join(root, 'lib')
      Dir[File.join(root, 'lib', 'test_support', '*.rb')].each do |lib|
        log "Loading #{lib}"
        require lib
      end
    end
  end
end
