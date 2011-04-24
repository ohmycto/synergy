CheckoutController.class_eval do
  private

  def after_payment
    if @order.shipping_method.calculator.is_a?(Calculator::CashOnDelivery)
      @order.complete_without_payment!
      after_complete
    end
  end
end
