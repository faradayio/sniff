require 'rubygems'
require 'jeweler'
require 'rspec/core/rake_task'
require 'rake/rdoctask'

if ENV['BUNDLE'] == 'true'
  begin
    require 'bundler'
    Bundler.setup
  rescue LoadError
    puts 'You need to install bundler, then run `bundle install` in order to run rake tasks'
  end
end

Jeweler::Tasks.new do |gem|                                                       
  gem.name = 'sniff'
  gem.authors = ["Derek Kastner"]
  gem.description = 'Provides data environment for emitter gems'
  gem.summary = 'Test support for Brighter Planet carbon gems'
  gem.email = 'derek.kastner@brighterplanet.com'
  gem.files = Dir.glob(File.join('lib', '**','*.rb')) +
    Dir.glob(File.join('lib', '**','*.csv')) +
    Dir.glob(File.join('vendor','**','*'))
  gem.test_files = Dir.glob(File.join('spec', '**', '*.rb')) +
    Dir.glob(File.join('lib', 'test_support', '**', '*.rb')) +
    Dir.glob(File.join('spec', 'spec.opts'))
  gem.homepage = 'http://github.com/brighterplanet/sniff'
  gem.require_paths = ["lib"]
  gem.add_dependency 'activerecord', '>=3.0.0.beta4'
  gem.add_dependency 'activesupport', '>=3.0.0.beta4'
  gem.add_dependency 'sqlite3-ruby', '>=1.3.0'
  gem.add_dependency 'common_name', '>=0.1.5'
  gem.add_dependency 'earth', '>= 0.0.14' unless ENV['LOCAL_EARTH']
  gem.add_dependency 'timeframe', '>=0.0.8'

  gem.add_development_dependency 'bundler'
  gem.add_development_dependency 'jeweler'
  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rspec', '>=2.0.0.beta.17'
  gem.add_development_dependency 'rcov'
  gem.add_development_dependency 'rdoc'
  gem.add_development_dependency 'fast_timestamp', '>=0.0.4'
end
Jeweler::GemcutterTasks.new

desc "Run all examples with RCov"
RSpec::Core::RakeTask.new('examples_with_rcov') do |t|
   t.rcov = true
   t.rcov_opts = ['--exclude', 'spec,~/.rvm,.rvm']
end

task :default => :spec

Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "flight #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
