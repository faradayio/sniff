class EgridRegion < ActiveRecord::Base
  set_primary_key :name
  
  has_many :egrid_subregions, :foreign_key => 'egrid_region_name'
  
  falls_back_on :loss_factor => 0.061311 # Ian
end
