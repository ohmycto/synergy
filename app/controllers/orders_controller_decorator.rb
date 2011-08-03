OrdersController.class_eval do
  def sberbank_invoice
    @order = Order.find_by_number(params[:id])
    @preferences = @order.payment_method.preferences
    render :layout => false
  end
  
  def juridical_invoice
    @order = Order.find_by_number(params[:id])
    @user = @order.user
    @preferences = Spree::Synergy::Config.get
    render :layout => false
  end
end
