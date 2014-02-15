Order.class_eval do
  # Updates the +payment_state+ attribute according to the following logic:
  #
  # paid          when +payment_total+ is equal to +total+
  # balance_due   when +payment_total+ is less than +total+
  # credit_owed   when +payment_total+ is greater than +total+
  # failed        when most recent payment is in the failed state
  #
  # The +payment_state+ value helps with reporting, etc. since it provides a quick and easy way to locate Orders needing attention.
  def update_payment_state
    if payment_total < total
      self.payment_state = payment_total > 0 ? "balance_due" : "pending"
      self.payment_state = "failed" if payments.present? and payments.last.state == "failed"
    elsif payment_total > total
      self.payment_state = "credit_owed"
    else
      self.payment_state = "paid"
    end

    if old_payment_state = self.changed_attributes["payment_state"]
      self.state_changes.create({
        :previous_state => old_payment_state,
        :next_state     => self.payment_state,
        :name           => "payment" ,
        :user_id        =>  (User.respond_to?(:current) && User.current && User.current.id) || self.user_id
      })
    end
  end
  
  def kopeek
    ('%.2f' % (total - total.to_i)).gsub(/0\./, '')
  end
end
