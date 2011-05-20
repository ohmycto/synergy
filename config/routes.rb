Rails.application.routes.draw do
  # Add your extension routes here
  match "/admin/products/import_from_yandex_market" => "admin/products#import_from_yandex_market", :as => :import_from_yandex_market
  match "/orders/:id/sberbank_invoice" => "orders#sberbank_invoice", :as => :orders_sberbank_invoice
end
