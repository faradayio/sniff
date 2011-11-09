module BrighterPlanet
  module Dirigible
    module Data
      def self.included(base)
        base.col :fuel_efficiency, :type => :float
        base.col :annual_distance_estimate, :type => :float
      end
    end
  end
end
