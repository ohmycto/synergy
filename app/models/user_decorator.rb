User.class_eval do
  validates :recipient, :juridical_address, :inn, :kpp, :recipient_bank,
            :settlement_acc, :corr, :bik, :presence => true, :if => :is_juridical?
  validates :inn, :numericality => true, :length => { :is => 10 }, :if => :is_juridical?
  validates :kpp, :bik, :numericality => true, :length => { :is => 9 }, :if => :is_juridical?
  validates :settlement_acc, :corr, :numericality => true, :length => { :is => 20 }, :if => :is_juridical?
  
  attr_accessible :juridical, :recipient, :juridical_address, :inn, :kpp, :recipient_bank, :settlement_acc, :corr, :bik, :nds
  
  def is_juridical?
    juridical?
  end
  
end