# coding: utf-8
PaymentMethod.class_eval do
  def self.internal
    pm = PaymentMethod.where(:environment => Rails.env, 
                             :display_on => "back_end", 
                             :type => "PaymentMethod::Check", 
                             :active => true).first
    
    pm ||= PaymentMethod::Check.create(:environment => Rails.env, 
                                :name => "Для внутренних расчётов", 
                                :display_on => "back_end", :active => true)  
    pm
  end
end
