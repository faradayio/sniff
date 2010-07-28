task :console do
  require 'sniff'
  cwd = Dir.pwd
  Sniff.init cwd

  require 'irb'
  ARGV.clear
  IRB.start
end
