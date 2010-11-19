require 'rubygems'

def require_or_fail(gems, message, failure_results_in_death = false)
  gems = [gems] unless gems.is_a?(Array)

  begin
    gems.each { |gem| require gem }
    yield
  rescue LoadError
    puts message
    exit if failure_results_in_death
  end
end

unless ENV['NOBUNDLE']
  message = <<-MESSAGE
In order to run tests, you must:
  * `gem install bundler`
  * `bundle install`
  MESSAGE
  require_or_fail('bundler',message,true) do
    Bundler.setup
  end
end

require_or_fail('jeweler', 'Jeweler (or a dependency) not available. Install it with: gem install jeweler') do
  Jeweler::Tasks.new do |gem|                                                       
    gem.name = 'sniff'
    gem.authors = ["Derek Kastner"]
    gem.description = 'Provides data environment for emitter gems'
    gem.summary = 'Test support for Brighter Planet carbon gems'
    gem.email = 'derek.kastner@brighterplanet.com'
    gem.files = Dir.glob(File.join('lib', '**','*.rb')) +
      Dir.glob(File.join('lib', '**','*.csv')) + Dir.glob(File.join('vendor','**','*'))
    gem.test_files = Dir.glob(File.join('spec', '**', '*.rb')) +
      Dir.glob(File.join('lib', 'test_support', '**', '*.rb')) +
      Dir.glob(File.join('spec', 'spec.opts'))
    gem.homepage = 'http://github.com/brighterplanet/sniff'
    gem.require_paths = ["lib"]
    gem.add_dependency 'activerecord', '~>3.0.0'
    gem.add_dependency 'activesupport', '~>3.0.0'
    gem.add_dependency 'aaronh-chronic', '~>0.3.9'
    gem.add_dependency 'common_name', '~>0.1.5'
    gem.add_dependency 'earth', '~> 0.3.1' unless ENV['LOCAL_EARTH']
    gem.add_dependency 'fast_timestamp', '~>0.0.4'
    gem.add_dependency 'sqlite3-ruby', '~>1.3.0'
    gem.add_dependency 'timeframe', '~>0.0.8'

    gem.add_development_dependency 'bundler'
    gem.add_development_dependency 'emitter'
    gem.add_development_dependency 'jeweler', '~> 1.4.0'
    gem.add_development_dependency 'rake'
    gem.add_development_dependency 'rcov'
    gem.add_development_dependency 'rdoc'
    gem.add_development_dependency 'rspec', '~>2.0.0.beta.17'
  end
  Jeweler::GemcutterTasks.new
end

require_or_fail('rspec', 'RSpec gem not found, rspec tasks unavailable') do
  require 'rspec/core/rake_task'

  desc "Run all examples"
  RSpec::Core::RakeTask.new('examples') do |t|
    if ENV['CUCUMBER_FORMAT']
      t.spec_opts = ['--format', ENV['CUCUMBER_FORMAT']]
    end
  end

  task :test => :examples
  task :default => :test
end

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "lodging #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
