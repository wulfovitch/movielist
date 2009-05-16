class MovieRenameCreatedAt < ActiveRecord::Migration
  def self.up
    rename_column :movies, :created_at, :bought_at 
  end

  def self.down
    rename_column :movies, :bought_at, :created_at 
  end
end
