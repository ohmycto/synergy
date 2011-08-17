class SecointHooks < Spree::ThemeSupport::HookListener
  insert_before :admin_order_show_buttons do
    %(
    <%= button_link_to t("courier_instructions"), orders_courier_instruction_path(@order), :target => "_blank" if @order.completed_at %>
    )
  end

  insert_after :admin_inside_head do
    %(
    <%= javascript_include_tag 'admin/inline_help.js', 'admin/jquery.simpletip-1.3.1.pack.js' %>
    <%= stylesheet_link_tag 'admin/inline_help.css', 'admin/synergy.css' %>
    )
  end
  
  insert_after :admin_configurations_menu do
    %(<tr>
      <td><%= link_to t("synergy_settings"), admin_synergy_settings_path %></td>
      <td><%= t("synergy_settings_desc") %></td>
    </tr>)
  end
  
  insert_after :admin_configurations_sidebar_menu do
    %(<li<%== ' class="active"' if controller.controller_name == 'synergy_settings' %>><%= link_to t("synergy_settings"), admin_synergy_settings_path %></li>)
  end
  
  insert_after :admin_order_tabs, 'admin/orders/juridical_tabs'
  
  insert_after :account_summary, 'users/status'
end
