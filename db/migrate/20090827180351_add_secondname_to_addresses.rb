class AddSecondnameToAddresses < ActiveRecord::Migration
    def self.up
      add_column :addresses, :secondname, :string
    end

    def self.down
      remove_column :addresses, :secondname
    end
end
