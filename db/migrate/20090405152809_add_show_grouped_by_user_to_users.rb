class AddShowGroupedByUserToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :show_grouped_by_user, :boolean, :default => 'false'
  end

  def self.down
    remove_column :users, :show_grouped_by_user
  end
end
