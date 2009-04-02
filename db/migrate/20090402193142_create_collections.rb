class CreateCollections < ActiveRecord::Migration
  def self.up
    create_table :collections do |t|
      t.string :collection_title, :null => false
      t.string :collection_original_title
      t.datetime :created_at
    end
  end

  def self.down
    drop_table :collections
  end
end
