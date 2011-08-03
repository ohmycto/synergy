class SynergyConfiguration < Configuration
  preference :juridical_enabled, :boolean, :default => false
  preference :recipient, :string
  preference :address, :string
  preference :inn, :string
  preference :kpp, :string
  preference :bank, :string
  preference :settlement_acc, :string
  preference :corr, :string
  preference :bik, :string
  preference :nds, :boolean, :default => false
  preference :director, :string
  preference :accountant, :string
end