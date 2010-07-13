task :environment do
  ENV['SCHEMA'] = File.join Sniff.root, 'db', 'schema.rb'
  ENV['FIXTURES_PATH'] = File.join Sniff.root, 'test', 'fixtures'
end

task :console do
  require 'sniff'
  cwd = Dir.pwd
  Sniff.init cwd

  require 'irb'
  ARGV.clear
  IRB.start
end
