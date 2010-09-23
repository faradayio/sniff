module BrighterPlanet
  module Dirigible
    module Characterization
      def self.included(base)
        base.characterize do
          has :make
          has :annual_distance_estimate, :measures => :length
        end
      end
    end
  end
end
