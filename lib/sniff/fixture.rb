require 'csv'

class Sniff
  module Fixture
    extend self
    
    def load_fixtures(fixtures_path)
      Encoding.default_external = 'UTF-8' if Object.const_defined?('Encoding')
      Dir.glob(File.join(fixtures_path, '**/*.csv')) do |fixture_file|
        model_name = File.basename(fixture_file, '.csv').singularize.camelize
        next unless Object.const_defined?(model_name)
        
        model = model_name.constantize
        model.delete_all
        CSV.foreach(fixture_file, :headers => true) do |row|
          ActiveRecord::Base.connection.insert_fixture(row, model.table_name) rescue ActiveRecord::RecordNotUnique
        end
      end
    end
  end
end
