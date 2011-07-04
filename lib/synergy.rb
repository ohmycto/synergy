# coding: utf-8
require 'spree_core'
require 'spree_auth'
require 'spree_api'
require 'spree_dash'
require 'spree_promo'
require 'spree_i18n'
require 'spree_static_content'
require 'spree_editor'
require 'spree_online_support'
require 'spree_robokassa'
require 'spree_yandex_market'
require 'spree_address_book'
require 'spree_dynamic_sitemaps'
require 'formtastic'
require 'russian'

require 'synergy_hooks'
require 'ext/number_helper'

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
        # store email address
        Spree::Config.set(:store_email => 'test@site.ru') unless Spree::Config[:store_email]
        # store phone
        Spree::Config.set(:store_phone => '+7 (495) 1234567') unless Spree::Config[:store_phone]
        # store address
        #Spree::Config.set(:store_address => 'Somewhere st. Nowhere')
      end
      
      ::ADDRESS_FIELDS.clear << ["lastname", "firstname", "secondname", "country", "state", "city", "zipcode", "address1", "phone"]
      ::ADDRESS_FIELDS.flatten!

      String.class_eval do
        def to_url
          self.parameterize
        end
     	end
     	
      # зарегистрировать калькулятор для доставки наложенным платежём
      Calculator::CashOnDelivery.register
      
      PaymentMethod::SberBankInvoice.register
      
      # добавить событие для перехода от шага доставки к шагу подтверждения, минуя шаг оплаты
      confirm_event = StateMachine::Event.new(Order.state_machine, :confirm_without_payment)
      confirm_event.transition :to => 'confirm'
      Order.state_machine.events << confirm_event
      
      # переопределение события :next для отображения шага подтверждения в любом случае
      next_event = StateMachine::Event.new(Order.state_machine, :next)
      next_event.transition :from => 'cart',     :to => 'address'
      next_event.transition :from => 'address',  :to => 'delivery'
      next_event.transition :from => 'delivery', :to => 'payment'
      next_event.transition :from => 'payment',  :to => 'confirm'
      next_event.transition :from => 'confirm',  :to => 'complete'     
      Order.state_machine.events << next_event
    end

    config.to_prepare &method(:activate).to_proc
  end
end
