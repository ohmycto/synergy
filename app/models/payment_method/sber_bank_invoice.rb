class PaymentMethod::SberBankInvoice < PaymentMethod::Check
  preference :recipient, :string
  preference :inn, :string
  preference :kpp, :string
  preference :corr, :string
  preference :bik, :string
  preference :settlement_acc, :string
  preference :recipient_bank, :string
  preference :recipient_bank_city, :string

  def desc
    "<p>#{I18n.t('sberbank_invoice')}</p>".html_safe
  end
end
