class SecointHooks < Spree::ThemeSupport::HookListener
  insert_before :admin_order_show_buttons do
    %(
    <%= button_link_to t("courier_instructions"), orders_courier_instruction_path(@order) if @order.completed_at %>
    )
  end

  insert_after :admin_inside_head do
    %(
    <%= javascript_include_tag 'admin/inline_help.js', 'admin/jquery.simpletip-1.3.1.pack.js' %>
    <%= stylesheet_link_tag 'admin/inline_help.css', 'admin/synergy.css' %>
    )
  end
end
