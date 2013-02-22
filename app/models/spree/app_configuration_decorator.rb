Spree::AppConfiguration.class_eval do
  preference :store_email, :string, :default => 'test@site.ru'
  preference :store_phone, :string, :default => '+7 (495) 1234567'
end