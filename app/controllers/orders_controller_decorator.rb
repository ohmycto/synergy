OrdersController.class_eval do
  def sberbank_invoice
    @order = Order.find_by_number(params[:id])
    @preferences = @order.payment_method.preferences
    render :layout => false
  end
end
