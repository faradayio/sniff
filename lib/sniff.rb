module Sniff
  extend self

  def root 
    File.join(File.dirname(__FILE__), '..')
  end

  # Prepares the environment for running tests against Earth data and emitter 
  # gems.
  #
  # local_root: Root directory of the emitter gem to be tested (path to the repo)
  #
  # options: 
  # * :earth is the list of domains Earth.init should load (default: none)
  # * :load_data determines whether fixture data is loaded (default: true)
  # * :sqllogdev is a Logger log device used by ActiveRecord (default: nil)
  # * :fixtures_path is the path to your gem's fixtures (default: local_root/lib/db/fixtures)
  # * :logdev is a Logger log device used for general logging (default: nil)
  def init(local_root, options = {})
    options[:earth] ||= :none

    Sniff::Database.init local_root, options

    if options[:cucumber]
      cukes = Dir.glob File.join(File.dirname(__FILE__), 'test_support', 'cucumber', '**', '*.rb')
      cukes.each { |support_file| require support_file }
    end
  end
end

require 'earth'

$:.unshift File.dirname(__FILE__)
require 'sniff/database'
require 'sniff/emitter'
