Rails.application.routes.draw do
  # Add your extension routes here
  match "/admin/products/import_from_yandex_market" => "admin/products#import_from_yandex_market", :as => :import_from_yandex_market
end
