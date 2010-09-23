require 'active_record'
require 'falls_back_on'
require 'dirigible'
require 'sniff'

class DirigibleRecord < ActiveRecord::Base
  include BrighterPlanet::Dirigible
  include Sniff::Emitter
  
  falls_back_on :fuel_efficiency => 20.182.miles_per_gallon.to(:kilometres_per_litre), # mpg https://brighterplanet.sifterapp.com/projects/30/issues/428
                :annual_distance_estimate => 11819.miles.to(:kilometres) # miles https://brighterplanet.sifterapp.com/projects/30/issues/428
end
