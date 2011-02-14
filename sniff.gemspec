# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "sniff/version"

Gem::Specification.new do |s|
  s.name = %q{sniff}
  s.version = Sniff::VERSION

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Derek Kastner"]
  s.date = "2011-01-27"
  s.description = %q{Provides development and test environment for emitter gems}
  s.email = %q{derek.kastner@brighterplanet.com}
  s.extra_rdoc_files = [
    "README.markdown"
  ]
  s.files = Dir.glob('lib/**/*')
  s.homepage = %q{http://github.com/brighterplanet/sniff}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Test support for Brighter Planet carbon gems}
  s.test_files = Dir.glob('spec/**/*')

  s.specification_version = 3
  s.add_runtime_dependency 'activerecord', '~> 3.0.0'
  s.add_runtime_dependency 'activesupport', '~> 3.0.0'
  s.add_runtime_dependency 'aaronh-chronic', '~> 0.3.9'
  s.add_runtime_dependency 'common_name', '~> 0.1.5'
  s.add_runtime_dependency 'cucumber', '~> 0.9.4'
  s.add_runtime_dependency 'earth', '~> 0.3.15'
  s.add_runtime_dependency 'fast_timestamp', '~> 0.0.4'
  s.add_runtime_dependency 'bueller', '~> 0.0.4'
  s.add_runtime_dependency 'rake'
  s.add_runtime_dependency 'rcov'
  s.add_runtime_dependency 'rdoc'
  s.add_runtime_dependency 'rocco'
  s.add_runtime_dependency 'rspec', '~> 2.0.0'
  s.add_runtime_dependency 'sqlite3-ruby', '~> 1.3.0'
  s.add_runtime_dependency 'timecop'
  s.add_runtime_dependency 'timeframe', '~> 0.0.8'
  s.add_development_dependency 'bundler'
  s.add_development_dependency 'emitter'
  s.add_development_dependency 'sandbox'
end

