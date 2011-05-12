UserSessionsController.class_eval do
  private
  def associate_user
    return unless current_user
    guest_order = current_order
    order = current_user.orders.where(:completed_at => nil).last
    if order
      if guest_order
        guest_order.line_items.each do |line_item|
          order.add_variant(line_item.variant, line_item.quantity)
        end
        order.save
        session[:return_to].gsub!(guest_order.number, order.number) if session[:return_to]
        guest_order.destroy
      end
      session[:order_id] = order.id
    else
      guest_order.associate_user!(current_user) if guest_order
    end
    
    session[:guest_token] = nil
  end
end
