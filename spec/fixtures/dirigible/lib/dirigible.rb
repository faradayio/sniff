require 'emitter'

module BrighterPlanet
  module Dirigible
    instance_variable_set :@emission_scope, @emission_scope if @emission_scope
    
    require 'leap'
    require 'cohort_scope'
    extend Leap::Subject
    include CarbonModel

    require 'characterizable'
    include Characterizable
    include Characterization
    add_implicit_characteristics

    require 'data_miner'
    include Data

    require 'summary_judgement'
    base.extend ::SummaryJudgement
    include Summarization

    require 'falls_back_on'
    require "dirigible/fallback"
    include Fallback

    include Relationships
  end
end
