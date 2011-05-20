CheckoutController.class_eval do
  private

  def after_payment
    if @order.shipping_method.calculator.is_a?(Calculator::CashOnDelivery)
      @order.confirm_without_payment!
    end
  end
end
