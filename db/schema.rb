# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120401003249) do

  create_table "authentications", :force => true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "token"
  end

  create_table "comments", :force => true do |t|
    t.integer  "micropost_id"
    t.integer  "user_id"
    t.string   "post_comment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["created_at"], :name => "index_comments_on_created_at"
  add_index "comments", ["micropost_id"], :name => "index_comments_on_micropost_id"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "microposts", :force => true do |t|
    t.string   "content"
    t.integer  "user_id"
    t.integer  "profile_id"
    t.integer  "belongs_to_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
    t.boolean  "anon",                            :default => false
    t.string   "stat",             :limit => nil
    t.integer  "truth_percentage"
  end

  add_index "microposts", ["user_id", "profile_id", "created_at"], :name => "index_microposts_on_user_id_and_profile_id_and_created_at"

  create_table "notifications", :force => true do |t|
    t.integer  "receiver_id"
    t.integer  "sender_id"
    t.string   "format"
    t.boolean  "read",        :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "noname",      :default => false
  end

  add_index "notifications", ["receiver_id"], :name => "index_notifications_on_receiver_id"
  add_index "notifications", ["sender_id"], :name => "index_notifications_on_sender_id"

  create_table "ratings", :force => true do |t|
    t.integer  "micropost_id"
    t.integer  "owner_id"
    t.integer  "rater_id"
    t.string   "rating"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ratings", ["micropost_id"], :name => "index_ratings_on_micropost_id"
  add_index "ratings", ["owner_id"], :name => "index_ratings_on_owner_id"
  add_index "ratings", ["rater_id"], :name => "index_ratings_on_rater_id"

  create_table "relationships", :force => true do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "relationships", ["followed_id"], :name => "index_relationships_on_followed_id"
  add_index "relationships", ["follower_id", "followed_id"], :name => "index_relationships_on_follower_id_and_followed_id", :unique => true
  add_index "relationships", ["follower_id"], :name => "index_relationships_on_follower_id"

  create_table "simple_captcha_data", :force => true do |t|
    t.string   "key",        :limit => 40
    t.string   "value",      :limit => 6
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "simple_captcha_data", ["key"], :name => "idx_key"

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "username"
    t.string   "password_hash"
    t.string   "password_salt"
    t.string   "reset_code",               :limit => 50
    t.datetime "reset_code_at"
    t.string   "state",                    :limit => 25
    t.string   "activation_code",          :limit => 100
    t.datetime "activated_at"
    t.datetime "activation_email_sent_at"
    t.boolean  "admin",                                   :default => false
    t.integer  "created_by"
    t.string   "photo_file_name"
    t.string   "photo_file_type"
    t.integer  "photo_file_size"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
    t.string   "blurb",                    :limit => nil
    t.boolean  "mail_subscription",                       :default => true
    t.string   "token"
    t.string   "facebook_id"
    t.string   "background_file_name"
    t.string   "background_content_type"
    t.integer  "background_file_size"
    t.datetime "background_updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email"
  add_index "users", ["username"], :name => "index_users_on_username"

end
