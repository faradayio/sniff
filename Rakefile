require 'bundler/setup'
Bundler.setup

ENV['EARTH_ENV'] = 'test'

require 'sniff'
require 'sniff/rake_tasks'
require 'earth/locality/petroleum_administration_for_defense_district'
Sniff::RakeTasks.define_tasks do |s|
  s.cucumber = false
  s.rspec = true
end
