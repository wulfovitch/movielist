class MovieAddColumnCreatedAt < ActiveRecord::Migration
  def self.up
    add_column :movies, :created_at, :datetime, :default => Time.now
    execute 'alter table movies alter created_at drop default'
  end

  def self.down
    remove_column :movies, :created_at
  end
end
