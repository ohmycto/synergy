require 'spree_core'
require 'synergy_hooks'

module Synergy
  class Engine < Rails::Engine

    config.autoload_paths += %W(#{config.root}/lib)

    def self.activate
      Dir.glob(File.join(File.dirname(__FILE__), "../app/**/*_decorator*.rb")) do |c|
        Rails.env.production? ? require(c) : load(c)
      end

      Time::DATE_FORMATS[:default] = "%d.%m.%Y - %H:%M"
      Date::DATE_FORMATS[:default] = "%d.%m.%Y"

      Time.zone = "Moscow"
      I18n.default_locale = :ru

      if Spree::Config.instance
        Spree::Config.set(:default_locale => :ru)
        Spree::Config.set(:default_country_id => 168)
        Spree::Config.set(:allow_ssl_in_production => false)
      end

      String.class_eval do
        def to_url
          self.parameterize
        end
     	end
      
    end

    config.to_prepare &method(:activate).to_proc
  end
end
