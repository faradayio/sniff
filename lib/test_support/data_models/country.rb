class Country < ActiveRecord::Base
  set_primary_key :iso_3166_code
  
  class << self
    def united_states
      find_by_iso_3166_code('US')
    end
  end
end
