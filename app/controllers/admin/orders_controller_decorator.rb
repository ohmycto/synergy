Admin::OrdersController.class_eval do
  def courier_instruction
    @order = Order.find_by_number(params[:id])
    render :layout => false
  end
  
  def juridical_info
    @user = Order.find_by_number(params[:id]).user
  end
end
