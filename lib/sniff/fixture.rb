require 'csv'

module Sniff
  module Fixture
    extend self
    
    def load_fixtures(fixtures_path)
      Encoding.default_external = 'UTF-8' if Object.const_defined?('Encoding')
      Dir.glob(File.join(fixtures_path, '**/*.csv')) do |fixture_file|
        model_name = File.basename(fixture_file, '.csv').singularize.camelize
        next unless Object.const_defined?(model_name)
        
        model = model_name.constantize
        model.auto_upgrade! unless model.table_exists?
        ActiveRecord::Base.logger.info "Loading fixture #{fixture_file}"
        CSV.foreach(fixture_file, :headers => true) do |row|
          ActiveRecord::Base.connection.insert_fixture(row, model.table_name) rescue ActiveRecord::RecordNotUnique
        end
      end
    end
  end
end
