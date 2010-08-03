module Sniff
  class RakeTask
    attr_accessor :earth_domains

    def initialize(name = 'console', desc = 'Load IRB console with Sniff environment')
      yield self if block_given?

      define_task
    end

    def earth_domains
      @earth_domains ||= :all
    end

  private
    def define_task
      task :console do
        require 'sniff'
        cwd = Dir.pwd
        Sniff.init cwd, :earth => earth_domains

        require 'irb'
        ARGV.clear
        IRB.start
      end
    end
  end
end
