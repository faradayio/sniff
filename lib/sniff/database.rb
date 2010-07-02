require 'fileutils'

module Sniff
  module Database
    extend self

    def connect(base_dir, options = {})
      options[:load_data] = true if options[:load_data].nil?

      require 'active_record'
      require 'sqlite3'
      FileUtils.mkdir_p db_path
      db_drop
      db_create
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

    def db_path
      File.join(Sniff.root, 'db')
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
      file = "#{Sniff.root}/db/schema.rb"
      load(file)
    end

    def load_data
      # TODO
    end

  private
    def load_models
      require 'data_miner'

      require 'falls_back_on'
      FallsBackOn::Initializer.init

      require 'cohort_scope'

      require 'leap'
      require 'characterizable'
      ActiveRecord::Base.send :include, Characterizable

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
