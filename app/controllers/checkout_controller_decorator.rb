CheckoutController.class_eval do
  private

  def after_payment
    if @order.shipping_method.calculator.is_a?(Calculator::CashOnDelivery)
      @order.payments.build(:payment_method => PaymentMethod.internal, :amount => @order.total)
      @order.confirm_without_payment!
    end
  end
  
  def before_delivery
    if current_user && current_user.juridical?
      @order.rate_hash.delete_if { |rh| rh[:shipping_method].calculator.class.name == "Calculator::CashOnDelivery" }
    end
  end
  
  def before_payment
    if current_user && current_user.juridical?
      if Spree::Synergy::Config[:juridical_enabled]
        # keep only juridical pm
        @order.available_payment_methods.delete_if { |pm| pm.class.name != "PaymentMethod::JuridicalInvoice" }
      else
        redirect_to account_url, :notice => t('juridical_disabled')
      end
    else
      # delete juridical pm for normal users
      @order.available_payment_methods.delete_if { |pm| pm.class.name == "PaymentMethod::JuridicalInvoice" }
    end
  end
end
