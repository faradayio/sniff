require 'cucumber'
require 'cucumber/rake/task'
require 'rake'
require 'rake/clean'
require 'rake/rdoctask'
require 'rake/tasklib'
require 'rocco'
require 'rocco/tasks'


module Sniff
  class RakeTasks
    def self.define_tasks(&blk)
      new(&blk).define_tasks
    end

    attr_accessor :earth_domains, :cucumber, :rspec, :rcov, :rocco

    def initialize
      self.earth_domains = :all
      self.cucumber = true
      self.rspec = false
      self.rcov = true
      self.rocco = true
      yield self if block_given?
    end

    def gemname
      @gemname ||= File.basename(Dir.glob(File.join(Dir.pwd, '*.gemspec')).first, '.gemspec')
    end

    def git(cmd, dir = nil, &blk)
      full_cmd = ''
      full_cmd << "cd #{dir} && " if dir
      full_cmd << "unset GIT_DIR && unset GIT_INDEX_FILE && unset GIT_WORK_TREE && git #{cmd}"
      sh full_cmd, &blk
    end

    def define_tasks
      task :console do
        require 'sniff'
        cwd = Dir.pwd
        Sniff.init cwd, :earth => earth_domains

        require 'irb'
        ARGV.clear
        IRB.start
      end

      if rocco
        Rocco::make 'docs/', "lib/#{gemname}/carbon_model.rb"

        desc 'Set up and build rocco docs'
        task :docs_init => :rocco

        desc 'Rebuild rocco docs'
        task :docs => ['pages:sync', :rocco]
        directory 'docs/'

        desc 'Update gh-pages branch'
        task :pages => :docs do
          rev = `git rev-parse --short HEAD`.strip
          git 'add *.html', 'docs'
          git "commit -m 'rebuild pages from #{rev}'", 'docs' do |ok,res|
            if ok
              verbose { puts "gh-pages updated" }
              git 'push -q o HEAD:gh-pages', 'docs' unless ENV['NO_PUSH']
            end
          end
        end

        # Update the pages/ directory clone
        namespace :pages do
          task 'sync' => ['.git/refs/heads/gh-pages', 'docs/.git/refs/remotes/o'] do |f|
            git 'fetch -q o', 'docs'
            git 'reset -q --hard o/gh-pages', 'docs'
            sh 'touch docs'
          end

          file '.git/refs/heads/gh-pages' => 'docs/' do |f|
            unless File.exist? f.name
              git 'branch gh-pages --track origin/gh-pages', 'docs' 
            end
          end

          file 'docs/.git/refs/remotes/o' => 'docs/' do |f|
            unless File.exist? f.name
              git 'init -q docs'
              git 'remote add o ../.git', 'docs'
            end
          end
        end

        CLOBBER.include 'docs/.git'
      end

      if cucumber
        desc 'Run all cucumber tests'
        Cucumber::Rake::Task.new(:features) do |t|
          if ENV['CUCUMBER_FORMAT']
            t.cucumber_opts = "features --format #{ENV['CUCUMBER_FORMAT']}"
          else
            t.cucumber_opts = 'features --format pretty'
          end
        end

        if rcov
          desc "Run cucumber tests with RCov"
          Cucumber::Rake::Task.new(:features_with_coverage) do |t|
            t.cucumber_opts = "features --format pretty"
            t.rcov = true
            t.rcov_opts = ['--exclude', 'features']
          end
        end
      end

      if rspec
        require 'rspec/core/rake_task'

        desc "Run all examples"
        RSpec::Core::RakeTask.new('examples') do |c|
          c.rspec_opts = '-Ispec'
        end

        if rcov
          desc "Run specs with RCov"
          RSpec::Core::RakeTask.new(:examples_with_coverage) do |t|
            t.rcov = true
            t.rcov_opts = ['--exclude', 'spec']
            t.rspec_opts = '-Ispec'
          end
        end
      end

      test_tasks = []
      test_tasks << :examples if rspec
      test_tasks << :features if cucumber
      unless test_tasks.empty?
        task :test => test_tasks
        task :default => :test
      end

      Rake::RDocTask.new do |rdoc|
        version = File.exist?('VERSION') ? File.read('VERSION') : ""

        rdoc.rdoc_dir = 'rdoc'
        rdoc.title = "#{gemname} #{version}"
        rdoc.rdoc_files.include('README*')
        rdoc.rdoc_files.include('lib/**/*.rb')
      end
    end
  end
end
