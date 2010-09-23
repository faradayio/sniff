module BrighterPlanet
  module Dirigible
    module Data
      def self.included(base)
        base.data_miner do
          schema do
            float    'fuel_efficiency'
            float    'annual_distance_estimate'
          end
          
          process :run_data_miner_on_belongs_to_associations
        end
      end
    end
  end
end
