require 'active_record'
require 'common_name'
require 'falls_back_on'

ActiveRecord::Base.class_eval do
  extend FallsBackOn

  def self._common_name
    name.underscore
  end
  include CommonName
end
