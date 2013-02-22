Spree::Admin::OrdersController.class_eval do
  def courier_instruction
    @order = Spree::Order.find_by_number(params[:id])
    render :layout => false
  end
end
