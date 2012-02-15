require 'rake'
require 'rake/clean'
require 'rdoc/task'
require 'rake/tasklib'

module Sniff
  class RakeTasks
    include Rake::DSL

    def self.define_tasks(&blk)
      new(&blk).define_tasks
    end

    attr_accessor :earth_domains, :cucumber, :rspec, :coverage, :rocco, :bueller, :watchr

    def initialize
      self.earth_domains = :all
      self.cucumber = true
      self.rspec = false
      self.coverage = true
      self.rocco = true
      self.bueller = true
      self.watchr = true
      yield self if block_given?
    end

    def ruby18?
      RUBY_VERSION =~ /^1\.8/ ? true : false
    end

    def simplecov=(val)
      self.coverage = val
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
      if coverage
        task :simplecov do
          require 'simplecov' 

          SimpleCov.start do
            add_filter '/spec/'
            add_filter '/features/'
            add_filter '/vendor/'
          end
        end
      end

      task :console do
        require 'sniff'
        Sniff.init Dir.pwd do
          earth_domains earth_domains
        end

        require 'irb'
        ARGV.clear
        IRB.start
      end

      if rocco
        require 'rocco'
        require 'rocco/tasks'

        directory 'docs/'

        Rocco::make 'docs/', "lib/#{gemname}/impact_model.rb"

        task :google_analyzed_rocco => ['docs/', :rocco] do
          source = File.read "docs/lib/#{gemname}/impact_model.html"
          unless source =~ /_gaq/
            source.sub! '</head>', <<-HTML
  <script type="text/javascript">
    var _gaq = _gaq || [];
    _gaq.push(['_setAccount', 'UA-1667526-20']);
    _gaq.push(['_trackPageview']);

    (function() {
      var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
      ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
      var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
    })();
  </script>
  <style type="text/css">
    td.docs h1 {
      margin-top: 0;
    }
    @media print {
      .code pre {
        white-space: pre-wrap;
      }
      .code {
        padding-left: 0 !important;
        padding-right: 0 !important;
      }
      .code .highlight {
        margin-left: 15px;
        margin-right: 15px;
      }
    }
  </style>
</head>
          HTML
            File.open "docs/lib/#{gemname}/impact_model.html", 'w' do |f|
              f.puts source
            end
          end
        end

        desc 'Update rocco docs on gh-pages branch'
        task :pages => ['pages:sync', :google_analyzed_rocco] do
          rev = `git rev-parse --short HEAD`.strip
          html = File.read "docs/lib/#{gemname}/impact_model.html"

          puts `git checkout gh-pages`
          File.open 'impact_model.html', 'w' do |f|
            f.puts html
          end

          puts `git add *.html`

          puts "Commiting with message 'Rebuild pages from #{rev}'"
          git "commit -m 'Rebuild pages from #{rev}'" do |ok,res|
            if ok
              puts "Pushing to origin"
              git 'push origin gh-pages' unless ENV['NO_PUSH']
            end
          end

          git 'checkout master'
        end

        namespace :pages do
          task 'sync' => ['.git/refs/heads/gh-pages'] do |f|
            git 'fetch origin'
            git 'checkout gh-pages'
            git 'reset --hard origin/gh-pages'
            git 'checkout master'
          end

          file '.git/refs/heads/gh-pages' do |f|
            unless File.exist? f.name
              git 'branch gh-pages'
            end
          end
        end

        CLOBBER.include 'docs/'
      end

      if cucumber
        require 'cucumber'
        require 'cucumber/rake/task'

        desc 'Run all cucumber tests'
        Cucumber::Rake::Task.new(:features) do |t|
          if ENV['CUCUMBER_FORMAT']
            t.cucumber_opts = "features --format #{ENV['CUCUMBER_FORMAT']}"
          else
            t.cucumber_opts = 'features --format pretty'
          end
        end

        if coverage
          task :features_with_coverage => [:simplecov, :features]
        end
      end

      if rspec
        require 'rspec/core/rake_task'

        desc "Run all examples"
        RSpec::Core::RakeTask.new('examples') do |c|
          if ENV['RSPEC_FORMAT']
            c.rspec_opts = "-Ispec --format #{ENV['RSPEC_FORMAT']}"
          else
            c.rspec_opts = '-Ispec --format documentation'
          end
        end

        if coverage
          task :examples_with_coverage => [:simplecov, :examples]
        end
      end

      directory 'log/'

      test_tasks = ['log/']
      test_tasks << :examples if rspec
      test_tasks << :features if cucumber
      unless test_tasks.empty?
        task :test => test_tasks
        task :default => :test
      end

      RDoc::Task.new do |rdoc|
        version = File.exist?('VERSION') ? File.read('VERSION') : ""

        rdoc.rdoc_dir = 'rdoc'
        rdoc.title = "#{gemname} #{version}"
        rdoc.rdoc_files.include('README*')
        rdoc.rdoc_files.include('lib/**/*.rb')
      end

      if bueller
        require 'bueller'
        Bueller::Tasks.new
      end

      if watchr
        namespace :watch do
          task :tests do
            require 'watchr'
            path = File.expand_path(Sniff.path(%w{lib sniff watcher.rb}))
            script = Watchr::Script.new Pathname(path)
            Watchr::Controller.new(script, Watchr.handler.new).run
          end
        end
      end
    end
  end
end
