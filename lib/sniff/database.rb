require 'active_support'

require 'sniff/fixture'

module Sniff
  class Database
    class << self
      # Configures a database used for testing emitter gems and
      # loads fixtures.
      #
      # settings: 
      # * fixtures.load determines whether fixture data is loaded (default: true)
      # * fixtures.path is the path to your gem's fixtures (default: local_root/features/support/db/fixtures)
      def init(settings)
        ActiveRecord::Base.logger = settings.database_logger
        ActiveRecord::Base.establish_connection settings.database_connection

        db = new settings
        db.init
        db
      end
    end

    attr_accessor :settings

    def initialize(settings)
      self.settings = settings
    end

    def init
      create_emitter_table
      populate_fixtures
    end

    def emitter_class
      return @emitter_class unless @emitter_class.nil?
      record_class_path = Dir.glob(File.join(settings.database_support_path, '*_record.rb')).first
      if record_class_path
        require record_class_path
        record_class = File.read(record_class_path)
        klass = record_class.scan(/class ([^\s]*Record)/).flatten.first
        @emitter_class = klass.constantize
      end
    end

    def create_emitter_table
      emitter_class.auto_upgrade! if emitter_class
    end

    def populate_fixtures
      Fixture.load_fixtures settings.database_fixtures_path if settings.database_fixtures_enabled
    end
  end
end
