module BrighterPlanet
  module Dirigible
    module Summarization
      def self.included(base)
        base.summarize do |has|
          has.adjective :model_year
          has.adjective :make
          has.adjective :model
          has.verb :own
        end
      end
    end
  end
end
