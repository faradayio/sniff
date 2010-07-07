class ClimateDivision < ActiveRecord::Base
  set_primary_key :name
  
  has_many :zip_codes, :foreign_key => 'climate_division_name'
  belongs_to :state, :foreign_key => 'state_postal_abbreviation'
  
  RADIUS = 750
end
