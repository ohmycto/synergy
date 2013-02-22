Deface::Override.new(
  :virtual_path => "spree/admin/orders/show",
  :name => "synergy_admin_order_show_buttons",
  :insert_after => "code[erb-silent]:contains('page_actions')",
  :text => "<li><%= button_link_to t(:courier_instructions), orders_courier_instruction_path(@order), :target => '_blank' if @order.completed_at %></li>",
  :disabled => false)