require 'fileutils'
require 'logger'

module Sniff
  class Database
    class << self
      def init(local_root, options = {})
        environments = []
        environments << really_init(local_root, options)

        unless local_root == Sniff.root
          environments << really_init(Sniff.root)
        end

        db_init local_root
        environments.each { |e| e.populate_fixtures }
      end

      def really_init(root, options = {})
        db = new root, options
        db.init
        db
      end

      def db_init(local_root)
        db_path = File.join(local_root, 'db')
        db_file_path = File.join(db_path, 'emitter_data.sqlite3')
        FileUtils.mkdir_p db_path
        db_drop db_file_path
        connect db_file_path
        db_create
        load_all_schemas
      end

      def connect(db_file_path)
        ActiveRecord::Base.establish_connection :adapter => 'sqlite3',
          :database => db_file_path,
          :pool => 5,
          :timeout => 5000
      end

      def db_drop(db_file_path)
        FileUtils.rm db_file_path if File.exists?(db_file_path)
      end

      def db_create
        ActiveRecord::Base.connection
      end

      def define_schema(&blk)
        @schemas = [] unless defined?(@schemas)
        @schemas << blk
      end

      def schemas
        @schemas
      end

      def load_all_schemas
        orig_std_out = STDOUT.clone
        STDOUT.reopen File.open(File.join('/tmp', 'schema_output'), 'w') 

        ActiveRecord::Schema.define(:version => 1) do
          ar_schema = self
          Sniff::Database.schemas.each do |s|
            ar_schema.instance_eval &s
          end
        end
      ensure
        STDOUT.reopen(orig_std_out)
      end
    end

    attr_accessor :root, :lib_path, :schema_path, :fixtures_path,
      :load_data, :fixtures, :logger

    def initialize(root, options)
      self.root = root
      self.lib_path = File.join(root, 'lib', 'test_support')
      self.load_data = options[:load_data]
      self.schema_path = options[:schema_path]
      self.fixtures_path = options[:fixtures_path]
      self.logger = Logger.new options[:logdev]
    end

    def log(str)
      logger.log str
    end

    def load_data?
      @load_data = true if @load_data.nil?
      @load_data
    end

    def schema_path
      @schema_path ||= File.join(lib_path, 'db', 'schema.rb')
    end

    def fixtures_path
      @fixtures_path ||= File.join(lib_path, 'db', 'fixtures')
    end

    def fixtures
      @fixtures ||= []
    end

    def init
      load_models
      load_supporting_libs
      read_schema
      read_fixtures if load_data?
    end

    def read_schema
      log "Reading schema #{schema_path}"
      load(schema_path)
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
        log "Loading fixture #{fixture_file}"
        Fixtures.create_fixtures(fixtures_path, fixture_file[(fixtures_path.size + 1)..-5])
      end
    end

    def load_supporting_libs
      $:.unshift File.join(root, 'lib')
      Dir[File.join(root, 'lib', 'test_support', '*.rb')].each do |lib|
        log "Loading #{lib}"
        require lib
      end
    end

    def load_models
      require 'falls_back_on'
      require 'falls_back_on/active_record_ext'

      require 'cohort_scope'
      require 'leap'
#      require 'data_miner'

      Dir["#{lib_path}/data_models/**/*.rb"].each do |lib|
        log "Loading model #{lib}"
        require lib
      end
    end
  end
end
