require 'active_record'
require 'active_record/railties/databases.rake'

task :environment do
  ENV['SCHEMA'] = File.join Sniff::ROOT, 'db', 'schema.rb'
  ENV['FIXTURES_PATH'] = File.join Sniff::ROOT, 'test', 'fixtures'
end

