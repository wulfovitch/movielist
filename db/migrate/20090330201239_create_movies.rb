class CreateMovies < ActiveRecord::Migration
  def self.up
    create_table :movies do |t|
      t.string :movie_title, :null => false
      t.string :movie_original_title
      t.integer :user_id, :null => false
      t.datetime :created_at
      t.string :imdb_link
      t.string :media_type # movie / series etc.
      t.string :disc_type # dvd / bluray / hd-dvd etc.
      t.string :parental_rating # fsk rating etc.
    end
  end

  def self.down
    drop_table :movies
  end
end
