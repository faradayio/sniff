require 'fileutils'

module Sniff
  module Database
    extend self

    def connect(base_dir)
      require 'active_record'
      require 'sqlite3'
      db_dir = File.join(base_dir, 'db')
      FileUtils.mkdir_p db_dir
      ActiveRecord::Base.establish_connection(
        :adapter => 'sqlite3',
        :database => File.join(db_dir, 'emitter_data.sqlite3'),
        :pool => 5,
        :timeout => 5000
      )
      load_models
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
