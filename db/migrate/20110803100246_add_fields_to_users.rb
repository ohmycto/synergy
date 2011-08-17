class AddFieldsToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :recipient, :string
    add_column :users, :juridical_address, :string
    add_column :users, :inn, :integer
    add_column :users, :kpp, :integer
    add_column :users, :recipient_bank, :string
    add_column :users, :settlement_acc, :string
    add_column :users, :corr, :string
    add_column :users, :bik, :string
    add_column :users, :nds, :boolean
    add_column :users, :juridical, :boolean, :default => false
  end

  def self.down
    remove_column :users, :juridical
    remove_column :users, :nds
    remove_column :users, :bik
    remove_column :users, :corr
    remove_column :users, :settlement_acc
    remove_column :users, :recipient_bank
    remove_column :users, :kpp
    remove_column :users, :inn
    remove_column :users, :juridical_address
    remove_column :users, :recipient
  end
end