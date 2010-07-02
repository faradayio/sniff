require 'active_record'
require 'active_record/railties/databases.rake'

task :environment do
  ENV['SCHEMA'] = File.join Sniff.root, 'db', 'schema.rb'
  ENV['FIXTURES_PATH'] = File.join Sniff.root, 'test', 'fixtures'
end

