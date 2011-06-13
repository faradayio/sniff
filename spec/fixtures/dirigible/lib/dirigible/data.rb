module BrighterPlanet
  module Dirigible
    module Data
      def self.included(base)
        base.create_table do
          float    'fuel_efficiency'
          float    'annual_distance_estimate'
        end
      end
    end
  end
end
