# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20090405152809) do

  create_table "collections", :force => true do |t|
    t.string   "collection_title",          :null => false
    t.string   "collection_original_title"
    t.datetime "created_at"
  end

  create_table "movies", :force => true do |t|
    t.string   "movie_title",          :null => false
    t.string   "movie_original_title"
    t.integer  "user_id",              :null => false
    t.datetime "created_at"
    t.string   "imdb_link"
    t.string   "media_type"
    t.string   "disc_type"
    t.string   "parental_rating"
    t.integer  "collection_id"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
  end

  create_table "users", :force => true do |t|
    t.string  "username"
    t.string  "realname"
    t.string  "hashed_password"
    t.boolean "show_grouped_by_user", :default => false
  end

end
