task :environment do
  ENV['SCHEMA'] = File.join Sniff.root, 'db', 'schema.rb'
  ENV['FIXTURES_PATH'] = File.join Sniff.root, 'test', 'fixtures'
end

task :console do
  require 'sniff'
  cwd = Dir.pwd
  DB_DIR = File.join cwd, 'features'
  FileUtils.mkdir_p(DB_DIR)
  Sniff::Database.init DB_DIR

  $:.unshift File.join(cwd, 'lib')
  Dir[File.join(DB_DIR, 'lib', '*.rb')].each do |lib|
    puts "Loading #{lib}"
    require lib
  end

  require 'irb'
  ARGV.clear
  IRB.start
end
