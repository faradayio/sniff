# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "sniff/version"

Gem::Specification.new do |s|
  s.name = %q{sniff}
  s.version = Sniff::VERSION

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Derek Kastner"]
  s.date = "2012-03-05"
  s.description = %q{Provides development and test environment for Brighter Planet's impact model libraries.}
  s.email = %q{derek.kastner@brighterplanet.com}
  s.extra_rdoc_files = [
    "README.markdown"
  ]
  s.files = Dir.glob('lib/**/*')
  s.homepage = %q{https://github.com/brighterplanet/sniff}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Provides development and test environment for Brighter Planet's impact model libraries.}
  s.test_files = Dir.glob('spec/**/*')

  s.add_runtime_dependency 'activesupport', '>=3'
  s.add_runtime_dependency 'aaronh-chronic', '>=0.3.9'
  s.add_runtime_dependency 'bueller', '>=0.0.5'
  s.add_runtime_dependency 'active_record_inline_schema'
  s.add_runtime_dependency 'cucumber'
  s.add_runtime_dependency 'earth', '>=0.4.5'
  s.add_runtime_dependency 'rake', '>=0.9.0'
  s.add_runtime_dependency 'simplecov'
  s.add_runtime_dependency 'rdoc'
  s.add_runtime_dependency 'dkastner-rocco'
  s.add_runtime_dependency 'rspec', '~> 2'
  s.add_runtime_dependency 'simplecov'
  s.add_runtime_dependency 'timecop'
  s.add_runtime_dependency 'timeframe', '>=0.0.8'
  s.add_runtime_dependency 'watchr'
  s.add_development_dependency 'sandbox'
  s.add_development_dependency 'emitter', '>= 0.5.0' unless ENV['LOCAL_EMITTER']
  s.add_development_dependency 'sqlite3-ruby'
end

