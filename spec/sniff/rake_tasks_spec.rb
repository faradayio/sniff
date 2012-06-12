require 'spec_helper'
require 'sandbox'
require 'sniff/rake_tasks'

describe Sniff::RakeTasks do
  def git(cmd, dir = nil, &blk)
    full_cmd = ''
    full_cmd << "cd #{dir} && " if dir
    full_cmd << "unset GIT_DIR && unset GIT_INDEX_FILE && unset GIT_WORK_TREE && git #{cmd}"
    `#{full_cmd}`
  end

  let(:tasks) { Sniff::RakeTask.new }
  let(:emitter_path) { File.expand_path '../../../', File.dirname(__FILE__) }
  let(:rakefile) do
    rakefile = <<-RAKEFILE
Encoding.default_external = Encoding.find 'UTF-8'

require '#{emitter_path}/lib/sniff/rake_tasks'

Sniff::RakeTasks.define_tasks
    RAKEFILE
  end

  describe '#define' do
    describe 'pages task' do
      it 'should commit any changed doc files' do
        Sandbox.play do |path|
          flight_path = File.join(path, 'flight')

          git "clone git://github.com/brighterplanet/flight.git #{flight_path}"

          File.open(File.join(flight_path, 'Rakefile'), 'w') do |f|
            f.puts rakefile
          end

          Dir.chdir flight_path do
            `git commit -am "new rakefile"`
            `git checkout -b gh-pages --track origin/gh-pages`
            `echo "<html>" > foobar.html`
            `git commit -am "dummy update"`
            `git checkout master && NO_PUSH=true rake pages`
            `git checkout gh-pages`

            `git log -n 1`.should =~ /rebuild pages/i
          end
        end
      end
    end
  end
end

