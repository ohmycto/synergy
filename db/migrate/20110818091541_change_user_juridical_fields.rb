class ChangeUserJuridicalFields < ActiveRecord::Migration
  def self.up
    change_column :users, :inn, :string
    change_column :users, :kpp, :string
  end

  def self.down
    change_column :users, :kpp, :integer
    change_column :users, :inn, :integer
  end
end