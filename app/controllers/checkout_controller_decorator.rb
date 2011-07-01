CheckoutController.class_eval do
  private

  def after_payment
    if @order.shipping_method.calculator.is_a?(Calculator::CashOnDelivery)
      @order.payments.build(:payment_method => PaymentMethod.internal, :amount => @order.total)
      @order.confirm_without_payment!
    end
  end
end
