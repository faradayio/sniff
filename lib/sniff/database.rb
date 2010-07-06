require 'fileutils'

module Sniff
  module Database
    extend self

    attr_accessor :db_path

    def init(db_path, options = {})
      self.db_path = File.join(db_path, 'db')
 
      options[:load_data] = true if options[:load_data].nil?

      require 'active_record'
      require 'sqlite3'
      FileUtils.mkdir_p db_path
      db_drop
      db_create
      load_schema
      load_data if options[:load_data]
      load_models
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
      schema = "#{Sniff.root}/db/schema.rb"
      orig_std_out = STDOUT.clone
      STDOUT.reopen(File.open(File.join(db_path, 'schema_output'), 'w'))
      load(schema)
    ensure
      STDOUT.reopen(orig_std_out)
    end

    def load_data
      require 'active_record/fixtures'

      fixtures_dir = "#{Sniff.root}/db/fixtures"
      Dir["#{fixtures_dir}/**/*.{yml,csv}"].each do |fixture_file|
        Fixtures.create_fixtures(fixtures_dir, fixture_file[(fixtures_dir.size + 1)..-5])
      end
    end

  private
    def load_models
      require 'data_miner'

      require 'falls_back_on'
      FallsBackOn::Initializer.init

      require 'cohort_scope'

      require 'leap'

      require 'sniff/airline.rb'
      require 'sniff/airport.rb'
      require 'sniff/flight_configuration.rb'
      require 'sniff/flight_distance_class.rb'
      require 'sniff/flight_domesticity.rb'
      require 'sniff/flight_fuel_type.rb'
      require 'sniff/flight_propulsion.rb'
      require 'sniff/flight_seat_class.rb'
      require 'sniff/flight_segment.rb'
      require 'sniff/flight_service.rb'
    end
  end
end
