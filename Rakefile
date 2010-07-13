require 'rubygems'
begin
  require 'bundler'
  Bundler.setup
rescue LoadError
  puts 'You need to install bundler, then run `bundle install` in order to run rake tasks'
end

require 'jeweler'                                                                 
Jeweler::Tasks.new do |gem|                                                       
  gem.name = 'sniff'
  gem.authors = ["Derek Kastner"]
  gem.description = File.read(File.join(File.dirname(__FILE__), 'README.markdown'))
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
  gem.add_dependency 'activerecord', '= 3.0.0.beta4'
  gem.add_dependency 'sqlite3-ruby', '= 1.3.0'
  gem.add_dependency 'falls_back_on', '= 0.0.2' unless ENV['LOCAL_FALLS_BACK_ON']
  gem.add_dependency 'cohort_scope', '= 0.0.5' unless ENV['LOCAL_COHORT_SCOPE']
  gem.add_dependency 'leap', '= 0.3.3' unless ENV['LOCAL_LEAP']
  gem.add_dependency 'summary_judgement', '= 1.3.8'
  gem.add_dependency 'fast_timestamp', '= 0.0.4'
  gem.add_dependency 'common_name', '= 0.1.5'
  gem.add_dependency 'conversions', '= 1.4.5'
  gem.add_dependency 'geokit', '=1.5.0'
  gem.add_dependency 'data_miner', '=0.4.44' unless ENV['LOCAL_DATA_MINER']

  gem.add_development_dependency 'bundler'
  gem.add_development_dependency 'jeweler'
  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'rcov'
  gem.add_development_dependency 'rdoc'
end
Jeweler::GemcutterTasks.new

require 'spec/rake/spectask'

desc "Run all examples with RCov"
Spec::Rake::SpecTask.new('examples_with_rcov') do |t|
   t.spec_files = FileList['spec/**/*_spec.rb']
   t.rcov = true
   t.rcov_opts = ['--exclude', 'spec,~/.rvm,.rvm']
end

task :default => :spec

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "flight #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
