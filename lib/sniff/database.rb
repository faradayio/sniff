require 'active_support'

require 'sniff/fixture'

module Sniff
  class Database
    class << self
      # Initialize a database used for testing emitter gems
      #
      # local_root: Root directory of the emitter gem to be tested (path to the repo)
      # options: 
      # * :fixtures_path is the path to your gem's fixtures (default: local_root/features/support/db/fixtures)
      def init(local_root, options = {})
        db_init options

        environments = []
        environments << init_environment(local_root, options)

        unless local_root == Sniff.root
          fixtures_path = File.join(Sniff.root, 'lib', 'test_support', 'db', 'fixtures')
          environments << init_environment(Sniff.root, :fixtures_path => fixtures_path)
        end
      end

      def init_environment(root, options = {})
        db = new root, options
        db.init
        db
      end

      # Connect to the database and set up an ActiveRecord logger
      def db_init(options)
        options = options.symbolize_keys
        options[:adapter] ||= options.delete(:db_adapter) || 'sqlite3'
        options[:database] ||= options.delete(:db_name) || ':memory:'
        ActiveRecord::Base.logger = Sniff.logger
        ActiveRecord::Base.establish_connection options
      end
    end

    attr_accessor :root, :test_support_path, :fixtures_path, :logger

    def initialize(root, options)
      self.root = root
      self.test_support_path = File.join(root, 'features', 'support')
      self.fixtures_path = options[:fixtures_path]
      self.logger = Sniff.logger
    end

    def log(str)
      logger.info str
    end

    def fixtures_path
      @fixtures_path ||= File.join(test_support_path, 'db', 'fixtures')
    end

    def init
      load_supporting_libs
      create_emitter_table
      Fixture.load_fixtures fixtures_path
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

    def create_emitter_table
      emitter_class.auto_upgrade! if emitter_class
    end

    def populate_fixtures
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
end
