require 'active_support'
require 'fileutils'
require 'logger'
require 'sqlite3'

module Sniff
  class Database
    class << self
      def init(local_root, options = {})
        environments = []
        environments << really_init(local_root, options)

        unless local_root == Sniff.root
          environments << really_init(Sniff.root)
        end

        db_init options
        environments.each { |e| e.populate_fixtures }
      end

      def really_init(root, options = {})
        db = new root, options
        db.init
        db
      end

      def db_init(options)
        ActiveRecord::Base.logger = Logger.new nil
        connect
        db_create
        earth_init(options[:earth])
      end

      def earth_init(domain)
        Earth.init domain, :apply_schemas => true
      end

      def connect
        ActiveRecord::Base.establish_connection :adapter => 'sqlite3',
          :database => ':memory:'
      end

      def db_drop(db_file_path)
        FileUtils.rm db_file_path if File.exists?(db_file_path)
      end

      def db_create
        ActiveRecord::Base.connection
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
      read_fixtures if load_data?
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
