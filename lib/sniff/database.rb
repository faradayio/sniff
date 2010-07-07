require 'fileutils'

module Sniff
  class Database
    def self.init(local_root, options = {})
      really_init local_root, options
      unless local_root == Sniff.root
        really_init Sniff.root, 
          :db_path => File.join(local_root, 'db')
      end
    end

    def self.really_init(root, options = {})
      db = new root, options
      db.init
    end

    attr_accessor :root, :lib_path, :db_path, :schema_path, :fixtures_path,
      :load_data

    def initialize(root, options)
      self.root = root
      self.db_path = options[:db_path]
      self.lib_path = File.join(root, 'lib', 'test_support')
      self.load_data = options[:load_data]
      self.schema_path = options[:schema_path]
      self.fixtures_path = options[:fixtures_path]
    end

    def load_data?
      @load_data = true if @load_data.nil?
      @load_data
    end

    def db_path
      @db_path ||= File.join(root, 'db')
    end

    def schema_path
      @schema_path ||= File.join(lib_path, 'db', 'schema.rb')
    end

    def fixtures_path
      @fixtures_path ||= File.join(lib_path, 'db', 'fixtures')
    end

    def init
      require 'active_record'
      require 'sqlite3'

      FileUtils.mkdir_p db_path
      db_drop
      db_create
      load_schema
      load_models
      load_data if load_data?
      load_supporting_libs
    end

    def ar_connect
      ActiveRecord::Base.establish_connection config
    end

    def config
      { :adapter => 'sqlite3',
        :database => db_file_path,
        :pool => 5,
        :timeout => 5000 }
    end

    def db_file_path
      File.join(db_path, 'emitter_data.sqlite3')
    end

    def db_drop
      FileUtils.rm db_file_path if File.exists?(db_file_path)
    end

    def db_create
      ar_connect
      ActiveRecord::Base.connection
    end

    def load_schema
      puts "Loading schema #{schema_path}"
      orig_std_out = STDOUT.clone
      STDOUT.reopen(File.open(File.join(db_path, 'schema_output'), 'w'))
      load(schema_path)
    ensure
      STDOUT.reopen(orig_std_out)
    end

    def load_data
      require 'active_record/fixtures'
      puts "loading fixtures from #{fixtures_path}/**/*.{yml,csv}"

      Dir["#{fixtures_path}/**/*.{yml,csv}"].each do |fixture_file|
        puts "Loading fixture #{fixture_file}"
        Fixtures.create_fixtures(fixtures_path, fixture_file[(fixtures_path.size + 1)..-5])
      end
    end

    def load_supporting_libs
      $:.unshift File.join(root, 'lib')
      Dir[File.join(root, 'lib', 'test_support', '*.rb')].each do |lib|
        puts "Loading #{lib}"
        require lib
      end
    end

  private
    def load_models
      ENV['DISABLE_FALLBACK_TABLE'] = 'true'
      require 'falls_back_on'
      require 'falls_back_on/active_record_ext'

      require 'cohort_scope'
      require 'leap'

      Dir["#{lib_path}/data_models/**/*.rb"].each do |lib|
        puts "Loading model #{lib}"
        require lib
      end
    end
  end
end
