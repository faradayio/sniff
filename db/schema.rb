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

  create_table "air_conditioner_uses", :primary_key => "name", :force => true do |t|
    t.float    "fugitive_emission"
    t.string   "fugitive_emission_units"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "aircraft", :primary_key => "icao_code", :force => true do |t|
    t.string   "manufacturer_name"
    t.string   "name"
    t.string   "bts_name"
    t.string   "bts_aircraft_type_code"
    t.string   "brighter_planet_aircraft_class_code"
    t.string   "fuel_use_aircraft_name"
    t.float    "m3"
    t.float    "m2"
    t.float    "m1"
    t.float    "endpoint_fuel"
    t.float    "seats"
    t.float    "distance"
    t.float    "load_factor"
    t.float    "freight_share"
    t.float    "payload"
    t.float    "weighting"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "aircraft_classes", :primary_key => "brighter_planet_aircraft_class_code", :force => true do |t|
    t.string   "name"
    t.float    "m1"
    t.float    "m2"
    t.float    "m3"
    t.float    "endpoint_fuel"
    t.integer  "seats"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "aircraft_manufacturers", :primary_key => "name", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "airlines", :primary_key => "iata_code", :force => true do |t|
    t.string   "name"
    t.string   "dot_airline_id_code"
    t.boolean  "international"
    t.float    "distance"
    t.float    "load_factor"
    t.float    "freight_share"
    t.float    "payload"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "seats"
  end

  create_table "airports", :primary_key => "iata_code", :force => true do |t|
    t.string   "name"
    t.string   "city"
    t.string   "country_name"
    t.string   "country_iso_3166_code"
    t.float    "latitude"
    t.float    "longitude"
    t.float    "seats"
    t.float    "distance"
    t.float    "load_factor"
    t.float    "freight_share"
    t.float    "payload"
    t.boolean  "international_origin"
    t.boolean  "international_destination"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "automobile_fuel_types", :primary_key => "code", :force => true do |t|
    t.string   "name"
    t.float    "emission_factor"
    t.string   "emission_factor_units"
    t.float    "annual_distance"
    t.string   "annual_distance_units"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "automobile_make_fleet_years", :primary_key => "name", :force => true do |t|
    t.string   "make_year_name"
    t.string   "make_name"
    t.string   "fleet"
    t.integer  "year"
    t.float    "fuel_efficiency"
    t.string   "fuel_efficiency_units"
    t.integer  "volume"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "automobile_make_years", :primary_key => "name", :force => true do |t|
    t.string   "make_name"
    t.integer  "year"
    t.float    "fuel_efficiency"
    t.string   "fuel_efficiency_units"
    t.integer  "volume"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "automobile_makes", :primary_key => "name", :force => true do |t|
    t.boolean  "major"
    t.float    "fuel_efficiency"
    t.string   "fuel_efficiency_units"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "automobile_model_years", :primary_key => "name", :force => true do |t|
    t.string   "make_name"
    t.string   "model_name"
    t.integer  "year"
    t.string   "make_year_name"
    t.float    "fuel_efficiency"
    t.string   "fuel_efficiency_units"
    t.float    "fuel_efficiency_city"
    t.string   "fuel_efficiency_city_units"
    t.float    "fuel_efficiency_highway"
    t.string   "fuel_efficiency_highway_units"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "automobile_models", :primary_key => "name", :force => true do |t|
    t.string   "make_name"
    t.float    "fuel_efficiency_city"
    t.string   "fuel_efficiency_city_units"
    t.float    "fuel_efficiency_highway"
    t.string   "fuel_efficiency_highway_units"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "automobile_size_classes", :primary_key => "name", :force => true do |t|
    t.float    "fuel_efficiency_city"
    t.string   "fuel_efficiency_city_units"
    t.float    "fuel_efficiency_highway"
    t.string   "fuel_efficiency_highway_units"
    t.float    "annual_distance"
    t.string   "annual_distance_units"
    t.string   "emblem"
    t.float    "hybrid_fuel_efficiency_city_multiplier"
    t.float    "hybrid_fuel_efficiency_highway_multiplier"
    t.float    "conventional_fuel_efficiency_city_multiplier"
    t.float    "conventional_fuel_efficiency_highway_multiplier"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "automobile_variants", :primary_key => "row_hash", :force => true do |t|
    t.string   "make_name"
    t.string   "model_name"
    t.string   "model_year_name"
    t.integer  "year"
    t.float    "fuel_efficiency_city"
    t.string   "fuel_efficiency_city_units"
    t.float    "fuel_efficiency_highway"
    t.string   "fuel_efficiency_highway_units"
    t.string   "fuel_type_code"
    t.string   "transmission"
    t.string   "drive"
    t.boolean  "turbo"
    t.boolean  "supercharger"
    t.integer  "cylinders"
    t.float    "displacement"
    t.float    "raw_fuel_efficiency_city"
    t.string   "raw_fuel_efficiency_city_units"
    t.float    "raw_fuel_efficiency_highway"
    t.string   "raw_fuel_efficiency_highway_units"
    t.integer  "carline_mfr_code"
    t.integer  "vi_mfr_code"
    t.integer  "carline_code"
    t.integer  "carline_class_code"
    t.boolean  "injection"
    t.string   "carline_class_name"
    t.string   "speeds"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "make_year_name"
  end

  create_table "automobiles", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "date"
    t.float    "fuel_efficiency"
    t.float    "urbanity"
    t.float    "annual_distance_estimate"
    t.float    "weekly_distance_estimate"
    t.float    "daily_distance_estimate"
    t.float    "daily_duration"
    t.date     "acquisition"
    t.boolean  "hybridity"
    t.date     "retirement"
    t.string   "variant_id"
    t.string   "make_id"
    t.string   "model_id"
    t.string   "model_year_id"
    t.string   "fuel_type_id"
    t.string   "size_class_id"
  end

  create_table "boat_propulsion_years", :force => true do |t|
    t.integer "year"
    t.float   "emission"
    t.integer "boat_propulsion_id"
  end

  create_table "boat_propulsions", :force => true do |t|
    t.string "name"
  end

  create_table "boats", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "date"
    t.string   "name"
    t.integer  "profile_id"
    t.boolean  "motorized"
    t.integer  "boat_propulsion_id"
  end

  create_table "breed_genders", :force => true do |t|
    t.integer  "breed_id"
    t.integer  "gender_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "weight"
  end

  create_table "breeds", :primary_key => "name", :force => true do |t|
    t.float    "weight"
    t.string   "weight_units"
    t.datetime "updated_at"
    t.datetime "created_at"
    t.string   "species_name"
  end

  create_table "bus_classes", :primary_key => "name", :force => true do |t|
    t.float    "distance"
    t.string   "distance_units"
    t.float    "passengers"
    t.float    "speed"
    t.string   "speed_units"
    t.float    "duration"
    t.string   "duration_units"
    t.float    "diesel_intensity"
    t.string   "diesel_intensity_units"
    t.float    "gasoline_intensity"
    t.string   "gasoline_intensity_units"
    t.float    "alternative_fuels_intensity"
    t.string   "alternative_fuels_intensity_units"
    t.float    "fugitive_air_conditioning_emission"
    t.string   "fugitive_air_conditioning_emission_units"
    t.datetime "updated_at"
    t.datetime "created_at"
  end

  create_table "bus_trip_patterns", :force => true do |t|
    t.string   "name"
    t.integer  "bus_trip_id"
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "weekly_bus_trips"
    t.integer  "profile_id"
  end

  create_table "bus_trips", :force => true do |t|
    t.date     "date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "duration"
    t.float    "distance_estimate"
    t.string   "bus_class_id"
  end

  create_table "census_divisions", :primary_key => "number", :force => true do |t|
    t.string   "name"
    t.string   "census_region_name"
    t.integer  "census_region_number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "census_regions", :primary_key => "number", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "climate_divisions", :primary_key => "name", :force => true do |t|
    t.float    "heating_degree_days"
    t.float    "cooling_degree_days"
    t.string   "state_postal_abbreviation"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "clothes_machine_uses", :primary_key => "name", :force => true do |t|
    t.float    "annual_energy_from_electricity_for_clothes_driers"
    t.string   "annual_energy_from_electricity_for_clothes_driers_units"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "countries", :primary_key => "iso_3166_code", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cruises", :force => true do |t|
    t.string  "name"
    t.integer "profile_id"
    t.date    "date"
  end

  create_table "diet_classes", :primary_key => "name", :force => true do |t|
    t.float    "intensity"
    t.string   "intensity_units"
    t.float    "red_meat_share"
    t.float    "poultry_share"
    t.float    "fish_share"
    t.float    "eggs_share"
    t.float    "nuts_share"
    t.float    "dairy_share"
    t.float    "cereals_and_grains_share"
    t.float    "fruit_share"
    t.float    "vegetables_share"
    t.float    "oils_and_sugars_share"
    t.datetime "updated_at"
    t.datetime "created_at"
  end

  create_table "diets", :force => true do |t|
    t.float    "proximity"
    t.float    "conventionality"
    t.integer  "size"
    t.float    "intensity"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "red_meat_share"
    t.float    "poultry_share"
    t.float    "fish_share"
    t.float    "eggs_share"
    t.float    "nuts_share"
    t.float    "dairy_share"
    t.float    "cereals_and_grains_share"
    t.float    "fruit_share"
    t.float    "vegetables_share"
    t.float    "oils_and_sugars_share"
    t.date     "start_date"
    t.date     "end_date"
    t.string   "diet_class_id"
  end

  create_table "dishwasher_uses", :primary_key => "name", :force => true do |t|
    t.float    "annual_energy_from_electricity_for_dishwashers"
    t.string   "annual_energy_from_electricity_for_dishwashers_units"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "dormitory_rooms", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.integer  "profile_id"
  end

  create_table "egrid_regions", :primary_key => "name", :force => true do |t|
    t.float    "loss_factor"
    t.string   "loss_factor_units"
    t.datetime "updated_at"
    t.datetime "created_at"
  end

  create_table "egrid_subregions", :primary_key => "abbreviation", :force => true do |t|
    t.string   "name"
    t.float    "electricity_emission_factor"
    t.string   "electricity_emission_factor_units"
    t.string   "nerc_abbreviation"
    t.string   "egrid_region_name"
    t.datetime "updated_at"
    t.datetime "created_at"
  end

  create_table "ferry_trips", :force => true do |t|
    t.string  "name"
    t.integer "profile_id"
    t.date    "date"
  end


  create_table "flight_aircraft", :force => true do |t|
    t.string   "name"
    t.integer  "seats"
    t.integer  "flight_fuel_type_id"
    t.float    "endpoint_fuel"
    t.integer  "flight_manufacturer_id"
    t.datetime "updated_at"
    t.datetime "created_at"
    t.date     "bts_begin_date"
    t.date     "bts_end_date"
    t.float    "load_factor"
    t.float    "freight_share"
    t.float    "m3"
    t.float    "m2"
    t.float    "m1"
    t.float    "distance"
    t.float    "payload"
    t.integer  "flight_aircraft_class_id"
    t.float    "multiplier"
    t.string   "manufacturer_name"
    t.string   "brighter_planet_aircraft_class_code"
    t.integer  "weighting"
    t.integer  "bts_aircraft_type"
  end

  create_table "flight_aircraft_classes", :force => true do |t|
    t.string  "name"
    t.integer "seats"
    t.integer "flight_fuel_type_id"
    t.float   "endpoint_fuel"
    t.string  "brighter_planet_aircraft_class_code"
    t.float   "m1"
    t.float   "m2"
    t.float   "m3"
  end

  create_table "flight_aircraft_seat_classes", :force => true do |t|
    t.integer  "flight_aircraft_id"
    t.integer  "flight_seat_class_id"
    t.integer  "seats"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "multiplier"
    t.boolean  "fresh"
  end

  create_table "flight_airline_aircraft", :force => true do |t|
    t.integer  "flight_airline_id"
    t.integer  "flight_aircraft_id"
    t.integer  "seats"
    t.datetime "updated_at"
    t.datetime "created_at"
    t.float    "total_seat_area"
    t.float    "average_seat_area"
    t.boolean  "fresh"
    t.float    "multiplier"
  end

  create_table "flight_airline_aircraft_seat_classes", :force => true do |t|
    t.integer  "seats"
    t.float    "pitch"
    t.float    "width"
    t.float    "multiplier"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "seat_area"
    t.string   "name"
    t.integer  "flight_airline_id"
    t.integer  "flight_aircraft_id"
    t.integer  "flight_seat_class_id"
    t.integer  "weighting"
    t.integer  "peers"
  end

  create_table "flight_airline_seat_classes", :force => true do |t|
    t.integer  "flight_seat_class_id"
    t.integer  "flight_airline_id"
    t.float    "multiplier"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "seats"
    t.boolean  "fresh"
  end

  create_table "flight_airlines", :force => true do |t|
    t.string  "name"
    t.string  "iata"
    t.string  "us_dot_airline_id"
    t.float   "load_factor"
    t.float   "freight_share"
    t.float   "distance"
    t.float   "multiplier"
    t.integer "seats"
    t.float   "payload"
    t.boolean "international"
  end

  create_table "flight_configurations", :primary_key => "name", :force => true do |t|
    t.string   "bts_aircraft_configuration_code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "flight_distance_classes", :primary_key => "name", :force => true do |t|
    t.float    "distance"
    t.string   "distance_units"
    t.datetime "updated_at"
    t.datetime "created_at"
  end

  create_table "flight_domesticities", :primary_key => "name", :force => true do |t|
    t.string   "bts_data_source_code"
    t.float    "distance"
    t.string   "distance_units"
    t.float    "freight_share"
    t.float    "load_factor"
    t.float    "seats"
    t.float    "payload"
    t.string   "payload_units"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "flight_fuel_types", :force => true do |t|
    t.string   "name"
    t.float    "emission_factor"
    t.float    "radiative_forcing_index"
    t.float    "density"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "flight_manufacturers", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "flight_patterns", :force => true do |t|
    t.string   "name"
    t.integer  "flight_id"
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "monthly_flights"
    t.integer  "profile_id"
  end

  create_table "flight_propulsions", :primary_key => "name", :force => true do |t|
    t.string   "bts_aircraft_group_code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "flight_seat_classes", :primary_key => "name", :force => true do |t|
    t.float    "multiplier"
    t.integer  "seats"
    t.datetime "updated_at"
    t.datetime "created_at"
  end

  create_table "flight_segments", :primary_key => "row_hash", :force => true do |t|
    t.string   "propulsion_id"
    t.integer  "bts_aircraft_group_code"
    t.string   "configuration_id"
    t.integer  "bts_aircraft_configuration_code"
    t.string   "distance_group"
    t.integer  "bts_distance_group_code"
    t.string   "service_class_id"
    t.string   "bts_service_class_code"
    t.string   "domesticity_id"
    t.string   "bts_data_source_code"
    t.integer  "departures_performed"
    t.integer  "payload"
    t.integer  "total_seats"
    t.integer  "passengers"
    t.integer  "freight"
    t.integer  "mail"
    t.integer  "ramp_to_ramp"
    t.integer  "air_time"
    t.float    "load_factor"
    t.float    "freight_share"
    t.integer  "distance"
    t.integer  "departures_scheduled"
    t.string   "airline_iata_code"
    t.string   "dot_airline_id_code"
    t.string   "unique_carrier_name"
    t.string   "unique_carrier_entity"
    t.string   "region"
    t.string   "current_airline_iata_code"
    t.string   "carrier_name"
    t.integer  "carrier_group"
    t.integer  "carrier_group_new"
    t.string   "origin_airport_iata_code"
    t.string   "origin_city_name"
    t.integer  "origin_city_num"
    t.string   "origin_state_abr"
    t.string   "origin_state_fips"
    t.string   "origin_state_nm"
    t.string   "origin_country_iso_3166_code"
    t.string   "origin_country_name"
    t.integer  "origin_wac"
    t.string   "dest_airport_iata_code"
    t.string   "dest_city_name"
    t.integer  "dest_city_num"
    t.string   "dest_state_abr"
    t.string   "dest_state_fips"
    t.string   "dest_state_nm"
    t.string   "dest_country_iso_3166_code"
    t.string   "dest_country_name"
    t.integer  "dest_wac"
    t.integer  "bts_aircraft_type_code"
    t.integer  "year"
    t.integer  "quarter"
    t.integer  "month"
    t.float    "seats"
    t.string   "payload_units"
    t.string   "freight_units"
    t.string   "mail_units"
    t.string   "distance_units"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "flight_services", :primary_key => "name", :force => true do |t|
    t.string   "bts_service_class_code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "flights", :force => true do |t|
    t.date     "date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "distance_estimate"
    t.integer  "seats_estimate"
    t.float    "load_factor"
    t.time     "time_of_day"
    t.integer  "year"
    t.integer  "emplanements_per_trip"
    t.integer  "trips"
    t.string   "origin_airport_id"
    t.string   "destination_airport_id"
    t.string   "distance_class_id"
    t.string   "aircraft_id"
    t.string   "aircraft_class_id"
    t.string   "propulsion_id"
    t.string   "fuel_type_id"
    t.string   "airline_id"
    t.string   "seat_class_id"
    t.string   "domesticity_id"
  end

  create_table "food_groups", :primary_key => "name", :force => true do |t|
    t.float    "intensity"
    t.string   "intensity_units"
    t.float    "energy"
    t.datetime "updated_at"
    t.datetime "created_at"
    t.string   "energy_units"
    t.string   "suggested_imperial_measurement"
  end

  create_table "genders", :primary_key => "name", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "hotel_stays", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.integer  "profile_id"
  end

  create_table "monthly_emission_variances", :force => true do |t|
    t.string  "component"
    t.integer "month"
    t.float   "variance"
    t.string  "month_name"
  end

  create_table "motorcycles", :force => true do |t|
    t.string   "name"
    t.date     "date"
    t.float    "fuel_efficiency"
    t.float    "annual_distance_estimate"
    t.float    "weekly_distance_estimate"
    t.date     "acquisition"
    t.date     "retirement"
    t.datetime "updated_at"
    t.datetime "created_at"
  end

  create_table "petroleum_administration_for_defense_districts", :primary_key => "code", :force => true do |t|
    t.string   "district_code"
    t.string   "district_name"
    t.string   "subdistrict_code"
    t.string   "subdistrict_name"
    t.datetime "updated_at"
    t.datetime "created_at"
  end

  create_table "pets", :force => true do |t|
    t.string   "name"
    t.float    "weight"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "acquisition"
    t.date     "retirement"
    t.string   "species_id"
    t.string   "breed_id"
    t.string   "gender_id"
  end

  create_table "rail_classes", :primary_key => "name", :force => true do |t|
    t.float    "distance"
    t.string   "distance_units"
    t.float    "passengers"
    t.float    "speed"
    t.string   "speed_units"
    t.float    "duration"
    t.string   "duration_units"
    t.float    "electricity_intensity"
    t.string   "electricity_intensity_units"
    t.float    "diesel_intensity"
    t.string   "diesel_intensity_units"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rail_trip_patterns", :force => true do |t|
    t.string   "name"
    t.integer  "rail_trip_id"
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "weekly_rail_trips"
    t.integer  "profile_id"
  end


  create_table "rail_trips", :force => true do |t|
    t.string   "name"
    t.date     "date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "duration"
    t.float    "distance_estimate"
    t.string   "rail_class_id"
  end

  create_table "residence_air_conditioner_uses", :force => true do |t|
    t.string   "name"
    t.float    "fugitive_emission"
    t.integer  "code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "residence_appliances", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.float    "annual_energy_from_electricity"
  end

  create_table "residence_classes", :primary_key => "name", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "residence_clothes_drier_uses", :force => true do |t|
    t.string   "name"
    t.integer  "code"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "annual_energy_from_electricity_for_clothes_driers"
  end

  create_table "residence_dishwasher_uses", :force => true do |t|
    t.string   "name"
    t.string   "raw_dwashuse"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "annual_energy_from_electricity_for_dishwashers"
  end

  create_table "residence_fuel_costs", :primary_key => "row_hash", :force => true do |t|
    t.string   "residence_fuel_type_name"
    t.integer  "year"
    t.integer  "month"
    t.float    "cost"
    t.string   "cost_units"
    t.string   "cost_description"
    t.string   "locatable_id"
    t.string   "locatable_type"
    t.datetime "updated_at"
    t.datetime "created_at"
  end

  create_table "residence_fuel_types", :primary_key => "name", :force => true do |t|
    t.float    "energy_per_unit"
    t.float    "emission_factor"
    t.string   "emission_factor_units"
    t.datetime "updated_at"
    t.datetime "created_at"
  end

  create_table "residence_survey_responses", :force => true do |t|
    t.integer  "department_of_energy_identifier"
    t.integer  "residence_class_id"
    t.float    "rooms"
    t.float    "floorspace"
    t.integer  "residents"
    t.integer  "residence_urbanity_id"
    t.date     "construction_year"
    t.boolean  "ownership"
    t.boolean  "thermostat_programmability"
    t.integer  "refrigerator_count"
    t.integer  "freezer_count"
    t.integer  "residence_dishwasher_use_id"
    t.integer  "residence_air_conditioner_use_id"
    t.integer  "residence_clothes_drier_use_id"
    t.float    "annual_energy_from_fuel_oil_for_heating_space"
    t.float    "annual_energy_from_fuel_oil_for_heating_water"
    t.float    "annual_energy_from_fuel_oil_for_appliances"
    t.float    "annual_energy_from_natural_gas_for_heating_space"
    t.float    "annual_energy_from_natural_gas_for_heating_water"
    t.float    "annual_energy_from_natural_gas_for_appliances"
    t.float    "annual_energy_from_propane_for_heating_space"
    t.float    "annual_energy_from_propane_for_heating_water"
    t.float    "annual_energy_from_propane_for_appliances"
    t.float    "annual_energy_from_wood"
    t.float    "annual_energy_from_kerosene"
    t.float    "annual_energy_from_electricity_for_clothes_driers"
    t.float    "annual_energy_from_electricity_for_dishwashers"
    t.float    "annual_energy_from_electricity_for_freezers"
    t.float    "annual_energy_from_electricity_for_refrigerators"
    t.float    "annual_energy_from_electricity_for_air_conditioners"
    t.float    "annual_energy_from_electricity_for_heating_space"
    t.float    "annual_energy_from_electricity_for_heating_water"
    t.float    "annual_energy_from_electricity_for_other_appliances"
    t.float    "weighting"
    t.float    "lighting_use"
    t.float    "lighting_efficiency"
    t.string   "raw_yearmade"
    t.string   "raw_washload"
    t.string   "raw_dryruse"
    t.string   "raw_usecenac"
    t.string   "raw_usewwac"
    t.integer  "census_division_id"
    t.integer  "heating_degree_days"
    t.integer  "cooling_degree_days"
    t.integer  "raw_totrooms"
    t.integer  "raw_ncombath"
    t.integer  "raw_nhafbath"
    t.integer  "raw_gargheat"
    t.integer  "raw_garage1c"
    t.integer  "raw_dgarg1c"
    t.integer  "raw_garage2c"
    t.integer  "raw_dgarg2c"
    t.integer  "raw_garage3c"
    t.integer  "raw_dgarg3c"
    t.integer  "raw_lgt1"
    t.integer  "raw_lgt1ee"
    t.integer  "raw_lgt4"
    t.integer  "raw_lgt4ee"
    t.integer  "raw_lgt12"
    t.integer  "raw_lgt12ee"
    t.integer  "raw_noutlgtnt"
    t.integer  "raw_ngaslight"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "typehuq"
    t.integer  "urbrur"
    t.integer  "dwashuse"
    t.integer  "division"
    t.integer  "census_region_id"
    t.float    "bathrooms"
  end

  create_table "residence_urbanities", :force => true do |t|
    t.string   "name"
    t.string   "raw_urbrur"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "residences", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "acquisition"
    t.string   "urbanity_id"
    t.float    "floorspace_estimate"
    t.integer  "floors"
    t.string   "residence_class_id"
    t.date     "construction_year"
    t.float    "annual_fuel_oil_volume_estimate"
    t.float    "annual_fuel_oil_cost"
    t.float    "monthly_natural_gas_volume_estimate"
    t.float    "monthly_natural_gas_cost"
    t.float    "monthly_electricity_use_estimate"
    t.float    "monthly_electricity_cost"
    t.float    "green_electricity"
    t.float    "annual_propane_volume_estimate"
    t.float    "annual_propane_cost"
    t.float    "annual_wood_volume_estimate"
    t.float    "annual_kerosene_volume_estimate"
    t.float    "annual_coal_volume_estimate"
    t.float    "annual_coal_cost"
    t.string   "clothes_machine_use_id"
    t.integer  "refrigerator_count"
    t.float    "lighting_efficiency"
    t.boolean  "ownership"
    t.integer  "freezer_count"
    t.string   "air_conditioner_use_id"
    t.string   "dishwasher_use_id"
    t.string   "zip_code_id"
    t.float    "occupation"
    t.integer  "residents"
    t.integer  "bedrooms"
    t.integer  "dining_rooms"
    t.integer  "living_rooms"
    t.integer  "kitchens"
    t.integer  "full_bathrooms"
    t.integer  "half_bathrooms"
    t.integer  "heated_garage_berths"
    t.integer  "other_rooms"
    t.date     "retirement"
    t.float    "bathrooms"
  end

  create_table "residential_energy_consumption_survey_responses", :primary_key => "department_of_energy_identifier", :force => true do |t|
    t.string   "residence_class_id"
    t.date     "construction_year"
    t.string   "construction_period"
    t.string   "urbanity_id"
    t.string   "dishwasher_use_id"
    t.string   "central_ac_use"
    t.string   "window_ac_use"
    t.string   "clothes_washer_use"
    t.string   "clothes_dryer_use"
    t.integer  "census_division_number"
    t.string   "census_division_name"
    t.integer  "census_region_number"
    t.string   "census_region_name"
    t.float    "rooms"
    t.float    "floorspace"
    t.string   "floorspace_units"
    t.integer  "residents"
    t.boolean  "ownership"
    t.boolean  "thermostat_programmability"
    t.integer  "refrigerator_count"
    t.integer  "freezer_count"
    t.float    "annual_energy_from_fuel_oil_for_heating_space"
    t.string   "annual_energy_from_fuel_oil_for_heating_space_units"
    t.float    "annual_energy_from_fuel_oil_for_heating_water"
    t.string   "annual_energy_from_fuel_oil_for_heating_water_units"
    t.float    "annual_energy_from_fuel_oil_for_appliances"
    t.string   "annual_energy_from_fuel_oil_for_appliances_units"
    t.float    "annual_energy_from_natural_gas_for_heating_space"
    t.string   "annual_energy_from_natural_gas_for_heating_space_units"
    t.float    "annual_energy_from_natural_gas_for_heating_water"
    t.string   "annual_energy_from_natural_gas_for_heating_water_units"
    t.float    "annual_energy_from_natural_gas_for_appliances"
    t.string   "annual_energy_from_natural_gas_for_appliances_units"
    t.float    "annual_energy_from_propane_for_heating_space"
    t.string   "annual_energy_from_propane_for_heating_space_units"
    t.float    "annual_energy_from_propane_for_heating_water"
    t.string   "annual_energy_from_propane_for_heating_water_units"
    t.float    "annual_energy_from_propane_for_appliances"
    t.string   "annual_energy_from_propane_for_appliances_units"
    t.float    "annual_energy_from_wood"
    t.string   "annual_energy_from_wood_units"
    t.float    "annual_energy_from_kerosene"
    t.string   "annual_energy_from_kerosene_units"
    t.float    "annual_energy_from_electricity_for_clothes_driers"
    t.string   "annual_energy_from_electricity_for_clothes_driers_units"
    t.float    "annual_energy_from_electricity_for_dishwashers"
    t.string   "annual_energy_from_electricity_for_dishwashers_units"
    t.float    "annual_energy_from_electricity_for_freezers"
    t.string   "annual_energy_from_electricity_for_freezers_units"
    t.float    "annual_energy_from_electricity_for_refrigerators"
    t.string   "annual_energy_from_electricity_for_refrigerators_units"
    t.float    "annual_energy_from_electricity_for_air_conditioners"
    t.string   "annual_energy_from_electricity_for_air_conditioners_units"
    t.float    "annual_energy_from_electricity_for_heating_space"
    t.string   "annual_energy_from_electricity_for_heating_space_units"
    t.float    "annual_energy_from_electricity_for_heating_water"
    t.string   "annual_energy_from_electricity_for_heating_water_units"
    t.float    "annual_energy_from_electricity_for_other_appliances"
    t.string   "annual_energy_from_electricity_for_other_appliances_units"
    t.float    "weighting"
    t.float    "lighting_use"
    t.string   "lighting_use_units"
    t.float    "lighting_efficiency"
    t.integer  "heating_degree_days"
    t.string   "heating_degree_days_units"
    t.integer  "cooling_degree_days"
    t.string   "cooling_degree_days_units"
    t.integer  "total_rooms"
    t.integer  "full_bathrooms"
    t.integer  "bedrooms"
    t.integer  "half_bathrooms"
    t.float    "bathrooms"
    t.integer  "lights_on_1_to_4_hours"
    t.integer  "efficient_lights_on_1_to_4_hours"
    t.integer  "lights_on_4_to_12_hours"
    t.integer  "efficient_lights_on_4_to_12_hours"
    t.integer  "lights_on_over_12_hours"
    t.integer  "efficient_lights_on_over_12_hours"
    t.integer  "outdoor_all_night_lights"
    t.integer  "outdoor_all_night_gas_lights"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "heated_garage"
    t.boolean  "attached_1car_garage"
    t.boolean  "detached_1car_garage"
    t.boolean  "attached_2car_garage"
    t.boolean  "detached_2car_garage"
    t.boolean  "attached_3car_garage"
    t.boolean  "detached_3car_garage"
    t.string   "air_conditioner_use_id"
    t.string   "clothes_machine_use_id"
  end

  create_table "species", :primary_key => "name", :force => true do |t|
    t.datetime "updated_at"
    t.datetime "created_at"
    t.integer  "population"
    t.float    "diet_emission_intensity"
    t.string   "diet_emission_intensity_units"
    t.float    "weight"
    t.string   "weight_units"
    t.float    "marginal_dietary_requirement"
    t.string   "marginal_dietary_requirement_units"
    t.float    "fixed_dietary_requirement"
    t.string   "fixed_dietary_requirement_units"
    t.float    "minimum_weight"
    t.string   "minimum_weight_units"
    t.float    "maximum_weight"
    t.string   "maximum_weight_units"
  end

  create_table "states", :primary_key => "postal_abbreviation", :force => true do |t|
    t.integer  "fips_code"
    t.string   "name"
    t.string   "census_division_number"
    t.string   "petroleum_administration_for_defense_district_code"
    t.datetime "updated_at"
    t.datetime "created_at"
  end

  create_table "urbanities", :primary_key => "name", :force => true do |t|
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

  create_table "zip_codes", :primary_key => "name", :force => true do |t|
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
