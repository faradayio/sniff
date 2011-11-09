require 'active_record'
require 'emitter'
require 'falls_back_on'
require 'sniff'

class DirigibleRecord < ActiveRecord::Base
  include BrighterPlanet::Dirigible
  include BrighterPlanet::Emitter
  
  falls_back_on :fuel_efficiency => 20.182.miles_per_gallon.to(:kilometres_per_litre),
                :annual_distance_estimate => 11819.miles.to(:kilometres)
end
