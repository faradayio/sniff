# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100701223036) do
  create_table "census_divisions", :primary_key => "number", :id => false, :force => true do |t|
    t.string   "number"
    t.string   "name"
    t.string   "census_region_name"
    t.integer  "census_region_number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "census_regions", :primary_key => "number", :id => false, :force => true do |t|
    t.string   "number"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "climate_divisions", :primary_key => "name", :id => false, :force => true do |t|
    t.string   "name"
    t.float    "heating_degree_days"
    t.float    "cooling_degree_days"
    t.string   "state_postal_abbreviation"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "countries", :primary_key => "iso_3166_code", :id => false, :force => true do |t|
    t.string   "iso_3166_code"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "egrid_regions", :primary_key => "name", :id => false, :force => true do |t|
    t.string   "name"
    t.float    "loss_factor"
    t.string   "loss_factor_units"
    t.datetime "updated_at"
    t.datetime "created_at"
  end

  create_table "egrid_subregions", :primary_key => "abbreviation", :id => false, :force => true do |t|
    t.string   "abbreviation"
    t.string   "name"
    t.float    "electricity_emission_factor"
    t.string   "electricity_emission_factor_units"
    t.string   "nerc_abbreviation"
    t.string   "egrid_region_name"
    t.datetime "updated_at"
    t.datetime "created_at"
  end

  create_table "genders", :primary_key => "name", :id => false, :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "petroleum_administration_for_defense_districts", :primary_key => "code", :id => false, :force => true do |t|
    t.string   "code"
    t.string   "district_code"
    t.string   "district_name"
    t.string   "subdistrict_code"
    t.string   "subdistrict_name"
    t.datetime "updated_at"
    t.datetime "created_at"
  end

  create_table "states", :primary_key => "postal_abbreviation", :id => false, :force => true do |t|
    t.string   "postal_abbreviation"
    t.integer  "fips_code"
    t.string   "name"
    t.string   "census_division_number"
    t.string   "petroleum_administration_for_defense_district_code"
    t.datetime "updated_at"
    t.datetime "created_at"
  end

  create_table "urbanities", :primary_key => "name", :id => false, :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "yearly_anonymous_emissions", :force => true do |t|
    t.string  "component"
    t.integer "year"
    t.float   "emission"
  end

  create_table "yearly_typical_emissions", :force => true do |t|
    t.string  "component"
    t.integer "year"
    t.float   "emission"
  end

  create_table "zip_codes", :primary_key => "name", :id => false, :force => true do |t|
    t.string   "name"
    t.string   "state_postal_abbreviation"
    t.string   "description"
    t.string   "latitude"
    t.string   "longitude"
    t.string   "egrid_subregion_abbreviation"
    t.string   "climate_division_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end
end
