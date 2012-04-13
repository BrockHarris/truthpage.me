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

ActiveRecord::Schema.define(:version => 20120413033036) do

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
    t.integer  "owner_id"
    t.string   "post_comment"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "micropost_content"
  end

  add_index "comments", ["created_at"], :name => "index_comments_on_created_at"
  add_index "comments", ["micropost_id"], :name => "index_comments_on_micropost_id"
  add_index "comments", ["owner_id"], :name => "index_comments_on_owner_id"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "microposts", :force => true do |t|
    t.string   "content"
    t.integer  "user_id"
    t.integer  "profile_id"
    t.integer  "belongs_to_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
    t.boolean  "anon"
    t.string   "stat",             :limit => nil
    t.integer  "truth_percentage"
  end

  add_index "microposts", ["user_id", "profile_id", "created_at"], :name => "index_microposts_on_user_id_and_profile_id_and_created_at"

  create_table "notifications", :force => true do |t|
    t.integer  "receiver_id"
    t.integer  "sender_id"
    t.string   "format"
    t.boolean  "read",              :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "noname",            :default => false
    t.string   "content"
    t.string   "micropost_content"
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
    t.string   "micropost_content"
  end

  add_index "ratings", ["micropost_id"], :name => "index_ratings_on_micropost_id"
  add_index "ratings", ["owner_id"], :name => "index_ratings_on_owner_id"
  add_index "ratings", ["rater_id"], :name => "index_ratings_on_rater_id"

  create_table "relationships", :force => true do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
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
    t.boolean  "admin"
    t.integer  "created_by"
    t.string   "photo_file_name"
    t.string   "photo_file_type"
    t.integer  "photo_file_size"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
    t.string   "blurb"
    t.boolean  "mail_subscription",                       :default => true
    t.string   "token"
    t.string   "facebook_id"
    t.string   "background_file_name"
    t.string   "background_content_type"
    t.integer  "background_file_size"
    t.datetime "background_updated_at"
    t.boolean  "follower_email",                          :default => true
  end

  create_table "vanities", :force => true do |t|
    t.string  "name"
    t.integer "vain_id"
    t.string  "vain_type"
  end

  add_index "vanities", ["name"], :name => "index_vanities_on_name", :unique => true
  add_index "vanities", ["vain_id"], :name => "index_vanities_on_vain_id"
  add_index "vanities", ["vain_type"], :name => "index_vanities_on_vain_type"

  create_table "vanity_conversions", :force => true do |t|
    t.integer "vanity_experiment_id"
    t.integer "alternative"
    t.integer "conversions"
  end

  add_index "vanity_conversions", ["vanity_experiment_id", "alternative"], :name => "by_experiment_id_and_alternative"

  create_table "vanity_experiments", :force => true do |t|
    t.string   "experiment_id"
    t.integer  "outcome"
    t.datetime "created_at"
    t.datetime "completed_at"
  end

  add_index "vanity_experiments", ["experiment_id"], :name => "index_vanity_experiments_on_experiment_id"

  create_table "vanity_metric_values", :force => true do |t|
    t.integer "vanity_metric_id"
    t.integer "index"
    t.integer "value"
    t.string  "date"
  end

  add_index "vanity_metric_values", ["vanity_metric_id"], :name => "index_vanity_metric_values_on_vanity_metric_id"

  create_table "vanity_metrics", :force => true do |t|
    t.string   "metric_id"
    t.datetime "updated_at"
  end

  add_index "vanity_metrics", ["metric_id"], :name => "index_vanity_metrics_on_metric_id"

  create_table "vanity_participants", :force => true do |t|
    t.string  "experiment_id"
    t.string  "identity"
    t.integer "shown"
    t.integer "seen"
    t.integer "converted"
  end

  add_index "vanity_participants", ["experiment_id", "converted"], :name => "by_experiment_id_and_converted"
  add_index "vanity_participants", ["experiment_id", "identity"], :name => "by_experiment_id_and_identity"
  add_index "vanity_participants", ["experiment_id", "seen"], :name => "by_experiment_id_and_seen"
  add_index "vanity_participants", ["experiment_id", "shown"], :name => "by_experiment_id_and_shown"
  add_index "vanity_participants", ["experiment_id"], :name => "index_vanity_participants_on_experiment_id"

end
