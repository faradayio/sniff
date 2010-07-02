require 'rubygems'
require 'bundler'
Bundler.setup

require 'bueller'
Bueller::Tasks.new 'sniff'
Bueller::GemcutterTasks.new

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
