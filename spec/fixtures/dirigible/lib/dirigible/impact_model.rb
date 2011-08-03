module BrighterPlanet
  module Dirigible
    module ImpactModel
      def self.included(base)
        base.decide :impact, :with => :characteristics do
          committee :carbon do # returns kg CO2
            quorum 'default' do
              100.0
            end
          end
        end
      end
    end
  end
end
