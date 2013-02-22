Spree::Core::Engine.routes.draw do
  match "/admin/orders/:id/courier_instruction" => "admin/orders#courier_instruction", :as => :orders_courier_instruction
end
