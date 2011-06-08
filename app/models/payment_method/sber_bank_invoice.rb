class PaymentMethod::SberBankInvoice < PaymentMethod
  preference :recipient, :string
  preference :inn, :string
  preference :kpp, :string
  preference :corr, :string
  preference :bik, :string
  preference :settlement_acc, :string
  preference :recipient_bank, :string
  preference :recipient_bank_city, :string

  def actions
    %w{capture void}
  end

  # Indicates whether its possible to capture the payment
  def can_capture?(payment)
    ['checkout', 'pending'].include?(payment.state)
  end

  # Indicates whether its possible to void the payment.
  def can_void?(payment)
    payment.state != 'void'
  end

  def capture(payment)
    payment.update_attribute(:state, 'pending') if payment.state == 'checkout'
    payment.complete
    true
  end

  def void(payment)
    payment.update_attribute(:state, 'pending') if payment.state == 'checkout'
    payment.void
    true
  end
  
  def desc
    "<p>#{I18n.t('sberbank_invoice')}</p>".html_safe
  end
end
