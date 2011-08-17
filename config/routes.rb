Rails.application.routes.draw do
  # Add your extension routes here
  match "/admin/products/import_from_yandex_market" => "admin/products#import_from_yandex_market", :as => :import_from_yandex_market
  match "/admin/orders/:id/courier_instruction" => "admin/orders#courier_instruction", :as => :orders_courier_instruction
  match "/orders/:id/sberbank_invoice" => "orders#sberbank_invoice", :as => :orders_sberbank_invoice
  
  namespace :admin do
    resource :synergy_settings, :only => [:show, :edit, :update]
  end
  
  match "/admin/orders/:id/juridical_info" => "admin/orders#juridical_info", :as => :orders_juridical_info
  match "/orders/:id/juridical_invoice" => "orders#juridical_invoice", :as => :orders_juridical_invoice
  
  resource :account, :controller => "users" do
    get :edit_status
    put :update_status
  end
  
end
