class SecointHooks < Spree::ThemeSupport::HookListener
  insert_after :admin_inside_head do
    %(
    <%= javascript_include_tag 'admin/inline_help.js', 'admin/jquery.simpletip-1.3.1.pack.js' %>
    <%= stylesheet_link_tag 'admin/inline_help.css' %>
    )
  end
end
