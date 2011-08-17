module Spree
  module Synergy
    class Config
      include Singleton
      include PreferenceAccess
      
      class << self
        def instance
          return nil unless ActiveRecord::Base.connection.tables.include?('configurations')
          SynergyConfiguration.find_or_create_by_name("Synergy configuration")
        end
      end
    end
  end
end