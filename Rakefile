require 'bundler'
Bundler.setup

require 'earth'
require 'earth/locality/petroleum_administration_for_defense_district'

$:.unshift File.expand_path('lib', File.dirname(__FILE__))
require 'sniff'
require 'sniff/rake_tasks'
Sniff::RakeTasks.define_tasks do |s|
  s.cucumber = false
  s.rspec = true
end
