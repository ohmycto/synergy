# coding: utf-8
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
        Spree::Config.set(:disable_bill_address => true)
        Spree::Config.set(:admin_interface_logo => "admin/logo.png")
        checkout_zone = Zone.first
        Spree::Config.set(:checkout_zone => checkout_zone.name) if checkout_zone
      end
      
      ADDRESS_FIELDS.clear << ["lastname", "firstname", "secondname", "country", "state", "city", "zipcode", "address1", "phone"]
      ADDRESS_FIELDS.flatten!

      String.class_eval do
        def to_url
          self.parameterize
        end
     	end
      
      # зарегистрировать калькулятор для доставки наложенным платежём
      Calculator::CashOnDelivery.register
      
      # добавить событие для перехода от шага доставки к шагу завершения, минуя шаг оплаты
      complete_event = StateMachine::Event.new(Order.state_machine, :complete_without_payment)
      complete_event.transition(:to => 'complete')
      Order.state_machine.events << complete_event
    end

    config.to_prepare &method(:activate).to_proc
  end
end
