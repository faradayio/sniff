require "dirigible/fallback"
require 'charisma'
require 'cohort_scope'
require 'data_miner'
require 'dirigible/carbon_model'
require 'dirigible/characterization'
require 'dirigible/data'
require 'dirigible/relationships'
require 'dirigible/summarization'
require 'emitter'
require 'falls_back_on'
require 'leap'
require 'summary_judgement'

module BrighterPlanet
  module Dirigible
    def self.included(base)
      instance_variable_set :@emission_scope, @emission_scope if @emission_scope
      
      base.extend Leap::Subject
      base.send :include, CarbonModel

      base.send :include, Charisma
      base.send :include, Characterization
#      add_implicit_characteristics

      base.send :include, Data

      base.extend SummaryJudgement
      base.send :include, Summarization

      base.send :include, Fallback

      base.send :include, Relationships
    end
  end
end
