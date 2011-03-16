class AddNameToProvider < ActiveRecord::Migration
  def self.up
    add_column :providers, :name, :string
    remove_column :providers, :user_id
  end

  def self.down
    add_column :providers, :user_id, :integer
    remove_column :providers, :name
  end
end
