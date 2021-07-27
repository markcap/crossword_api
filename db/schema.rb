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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2018_10_17_192751) do

  create_table "actor_publications", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.integer "actor_id"
    t.integer "publication_id"
    t.integer "user_id"
    t.index ["actor_id"], name: "index_actor_publications_on_actor_id"
    t.index ["publication_id"], name: "index_actor_publications_on_publication_id"
    t.index ["user_id"], name: "index_actor_publications_on_user_id"
  end

  create_table "actors", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.integer "feature_id", null: false
    t.string "name", limit: 64, null: false
    t.text "description", limit: 16777215
    t.string "image_path", limit: 128
    t.integer "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "tag_count"
    t.index ["feature_id", "name"], name: "idx_feature_name", unique: true
  end

  create_table "admin_settings", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "setting_name"
    t.string "setting_value", limit: 512
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["setting_name"], name: "index_admin_settings_on_setting_name", unique: true
  end

  create_table "assets", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "feature_id", null: false
    t.integer "feature_depot_id"
    t.string "asset_type", limit: 9, default: "webready", null: false
    t.string "image_coloration", limit: 5
    t.string "colorspace", limit: 9
    t.string "image_format", limit: 9
    t.date "issue_date"
    t.date "original_date"
    t.boolean "web_preferred"
    t.string "filename", limit: 128, null: false
    t.string "filepath"
    t.string "archive_basepath", limit: 128
    t.string "archive_filepath"
    t.string "mime_type", limit: 64
    t.integer "file_size"
    t.integer "width"
    t.integer "height"
    t.integer "display_order"
    t.string "headline"
    t.string "asset_uuid", limit: 32, default: ""
    t.datetime "created_at", null: false
    t.timestamp "updated_at", null: false
    t.index ["asset_uuid"], name: "idx_asset_uuid"
    t.index ["feature_depot_id"], name: "feature_depot_id"
    t.index ["feature_id", "issue_date"], name: "idx_feature_issue_date"
    t.index ["filepath"], name: "filepath", unique: true
    t.index ["issue_date"], name: "idx_issue_date"
  end

  create_table "audits", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "auditable_id"
    t.string "auditable_type"
    t.integer "associated_id"
    t.string "associated_type"
    t.integer "user_id"
    t.string "user_type"
    t.string "username"
    t.string "action"
    t.text "audited_changes"
    t.integer "version", default: 0
    t.string "comment"
    t.string "remote_address"
    t.datetime "created_at"
    t.index ["associated_id", "associated_type"], name: "associated_index"
    t.index ["auditable_id", "auditable_type"], name: "auditable_index"
    t.index ["created_at"], name: "index_audits_on_created_at"
    t.index ["user_id", "user_type"], name: "user_index"
  end

  create_table "auxiliary_assets", id: :integer, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "feature_id", null: false
    t.string "code", limit: 64, null: false
    t.string "filename", limit: 128, default: "", null: false
    t.string "path", limit: 128
    t.string "mime_type", limit: 100
    t.integer "filesize"
    t.string "uuid", limit: 32
    t.datetime "created_at", null: false
    t.timestamp "updated_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.index ["feature_id"], name: "feature_id"
    t.index ["filename"], name: "filename"
  end

  create_table "creator_features", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "creator_id", null: false
    t.integer "feature_id", null: false
    t.string "role", limit: 64
    t.text "biography", limit: 16777215
    t.string "mugshot_path"
    t.integer "position"
    t.datetime "created_at", null: false
    t.timestamp "updated_at", null: false
    t.index ["creator_id", "feature_id"], name: "idx_creator_feature", unique: true
    t.index ["feature_id"], name: "idx_feature"
    t.index ["position"], name: "idx_position"
  end

  create_table "creators", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "first_name", limit: 64, null: false
    t.string "last_name", limit: 64, null: false
    t.string "full_name", limit: 128, null: false
    t.string "email", limit: 128, default: ""
    t.string "phone", limit: 64
    t.boolean "private", default: false, null: false
    t.string "address"
    t.datetime "created_at", null: false
    t.timestamp "updated_at", null: false
  end

  create_table "depots", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "depot_code", limit: 32, default: "", null: false
    t.string "name", limit: 64, default: "", null: false
    t.integer "syndicate_id", null: false
    t.string "protocol", limit: 16
    t.string "host", limit: 128
    t.string "username", limit: 32
    t.string "password", limit: 32
    t.string "basepath"
    t.string "active", limit: 8, default: "active", null: false
    t.text "notes"
    t.datetime "created_at", null: false
    t.timestamp "updated_at", null: false
    t.index ["depot_code"], name: "dp_code", unique: true
    t.index ["syndicate_id"], name: "idx_syndicate"
  end

  create_table "editors", id: :integer, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "feature_id", null: false
    t.integer "user_id", null: false
    t.string "type", limit: 6, default: "first", null: false
    t.datetime "created_at", null: false
    t.timestamp "updated_at", null: false
    t.index ["feature_id"], name: "feature_id"
    t.index ["user_id"], name: "user_id"
  end

  create_table "external_users", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "username", limit: 32, null: false
    t.string "first_name", limit: 64, null: false
    t.string "last_name", limit: 64, null: false
    t.string "email"
    t.string "encrypted_password", limit: 128, default: "", null: false
    t.string "password_salt", default: "", null: false
    t.string "reset_password_token"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.integer "feature_id"
    t.integer "creator_id"
    t.datetime "created_at", null: false
    t.timestamp "updated_at", null: false
    t.integer "group_id"
    t.index ["feature_id"], name: "feature_id"
    t.index ["username"], name: "username", unique: true
  end

  create_table "feature_depots", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "depot_id", null: false
    t.integer "feature_id", null: false
    t.string "remote_path"
    t.string "regular_expression", limit: 128
    t.text "notes"
    t.integer "weekday", limit: 2, default: 0, null: false
    t.string "active", limit: 8, default: "inactive", null: false
    t.datetime "created_at", null: false
    t.timestamp "updated_at", null: false
    t.boolean "master_only"
    t.index ["active"], name: "idx_active"
    t.index ["depot_id"], name: "depot_id"
    t.index ["feature_id"], name: "feature_id"
  end

  create_table "feature_details", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "feature_id", null: false
    t.text "overview", limit: 16777215
    t.text "editor_notes", limit: 16777215
    t.string "banner_path"
    t.string "icon_path"
    t.integer "spotlight_asset_id"
    t.string "spotlight_image_path"
    t.text "spotlight_embed_code"
    t.text "weblinks", limit: 16777215
    t.datetime "created_at", null: false
    t.timestamp "updated_at", null: false
    t.index ["feature_id"], name: "idx_feature_id", unique: true
  end

  create_table "feature_watchers", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "feature_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.timestamp "updated_at", null: false
    t.index ["feature_id"], name: "feature_id"
    t.index ["user_id"], name: "user_id"
  end

  create_table "features", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "language_id"
    t.integer "syndicate_id", default: 1
    t.string "feature_code", limit: 32, default: "", null: false
    t.string "name", limit: 64, null: false
    t.string "feature_type", limit: 12, default: "comic", null: false
    t.string "phylum", limit: 16
    t.string "category", limit: 64
    t.string "format", limit: 9, default: "other", null: false
    t.string "alt_format", limit: 9, default: "other", null: false
    t.integer "alt_format_weekday", limit: 2, default: 0, null: false
    t.string "frequency_detail", default: "smtwrfa"
    t.string "coloration_pattern", limit: 12
    t.boolean "color", default: true
    t.text "about", limit: 16777215
    t.text "notes", limit: 16777215
    t.string "classification", limit: 64
    t.string "short_name", limit: 64, null: false
    t.string "sort_name", limit: 64, null: false
    t.string "copyright", default: "© "
    t.string "active", limit: 8, default: "active", null: false
    t.date "activation_date"
    t.boolean "corporate_site", default: false
    t.boolean "promoted", default: false
    t.boolean "syndicated", default: false
    t.string "avatar"
    t.string "icon"
    t.string "hero"
    t.string "header"
    t.string "recommendation"
    t.string "ubadge"
    t.string "political_slant", limit: 6
    t.string "byline", limit: 128
    t.boolean "amu_reprints"
    t.datetime "created_at", null: false
    t.timestamp "updated_at", null: false
    t.index ["amu_reprints"], name: "index_features_on_amu_reprints"
    t.index ["feature_code"], name: "idx_feature_code", unique: true
    t.index ["language_id"], name: "language_id"
    t.index ["name"], name: "idx_feature_name", unique: true
    t.index ["sort_name"], name: "sort_name", unique: true
    t.index ["syndicate_id"], name: "syndicate_id"
  end

  create_table "genres", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "name"
    t.boolean "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "groups", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.string "description"
    t.datetime "created_at", null: false
    t.timestamp "updated_at", null: false
  end

  create_table "languages", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "code", limit: 16
    t.string "name", limit: 64, null: false
    t.index ["code"], name: "idx_language_code", unique: true
  end

  create_table "license_features", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.integer "feature_id", null: false
    t.integer "license_id", null: false
    t.index ["license_id"], name: "index_license_features_on_license_id"
  end

  create_table "licenses", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "name", null: false
    t.index ["name"], name: "index_licenses_on_name", unique: true
  end

  create_table "missed_searches", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "term"
    t.integer "miss_count"
    t.boolean "ignore", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "news_items", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "title", null: false
    t.text "entry", limit: 16777215, null: false
    t.string "story_type", limit: 20, default: "news", null: false
    t.integer "feature_id"
    t.date "publish_date"
    t.datetime "created_at", null: false
    t.timestamp "updated_at", null: false
    t.index ["feature_id"], name: "feature_id"
  end

  create_table "oauth_access_tokens", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.integer "resource_owner_id"
    t.integer "application_id"
    t.string "token", null: false
    t.string "refresh_token"
    t.integer "expires_in"
    t.datetime "revoked_at"
    t.datetime "created_at", null: false
    t.string "scopes"
    t.string "previous_refresh_token", default: "", null: false
    t.index ["refresh_token"], name: "index_oauth_access_tokens_on_refresh_token", unique: true
    t.index ["resource_owner_id"], name: "index_oauth_access_tokens_on_resource_owner_id"
    t.index ["token"], name: "index_oauth_access_tokens_on_token", unique: true
  end

  create_table "process_details", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "feature_id", null: false
    t.string "proc_key"
    t.string "proc_value"
    t.text "notes", limit: 16777215
    t.datetime "created_at", null: false
    t.timestamp "updated_at", null: false
    t.index ["feature_id", "proc_key", "proc_value"], name: "feature_id_2", unique: true
    t.index ["feature_id"], name: "feature_id"
  end

  create_table "publications", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "feature_id", null: false
    t.date "asset_issue_date", null: false
    t.date "publish_date", null: false
    t.integer "episode"
    t.string "title"
    t.datetime "metadata_updated_at"
    t.integer "metadata_updated_by"
    t.datetime "created_at", null: false
    t.timestamp "updated_at", null: false
    t.index ["asset_issue_date"], name: "asset_issue_date"
    t.index ["feature_id", "asset_issue_date"], name: "idx_feature_issue_date"
    t.index ["feature_id", "publish_date"], name: "idx_feature_publish_date", unique: true
    t.index ["metadata_updated_at"], name: "index_publications_on_metadata_updated_at"
    t.index ["metadata_updated_by"], name: "index_publications_on_metadata_updated_by"
    t.index ["publish_date"], name: "idx_publish_date"
  end

  create_table "puzzle_details", id: :integer, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "feature_id", null: false
    t.text "control_data"
    t.text "embed_params"
    t.string "engine", limit: 9, default: "html5"
    t.integer "embed_width"
    t.integer "embed_height"
    t.string "embed_background_color", limit: 7, default: "#FFFFFF", null: false
    t.string "key_prefix", limit: 32
    t.string "remote_shell_url"
    t.string "weekly_leaderboard_url"
    t.datetime "created_at", null: false
    t.timestamp "updated_at", null: false
    t.index ["feature_id"], name: "feature_id"
  end

  create_table "reprint_carts", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "email"
    t.string "publication_method"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "phone"
    t.string "company_name"
    t.text "notes"
    t.boolean "checked_out"
    t.boolean "na_rights"
    t.boolean "world_rights"
    t.boolean "electronic_rights"
    t.boolean "rush_fee"
    t.index ["checked_out"], name: "index_reprint_carts_on_checked_out"
  end

  create_table "reprint_items", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.integer "reprint_cart_id"
    t.integer "publication_id"
    t.string "referring_site"
  end

  create_table "series", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", limit: 128, null: false
    t.datetime "created_at", null: false
    t.timestamp "updated_at", null: false
    t.index ["name"], name: "idx_series_name", unique: true
  end

  create_table "series_publications", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "series_id", null: false
    t.integer "publication_id", null: false
    t.integer "sequence", limit: 2
    t.datetime "created_at", null: false
    t.timestamp "updated_at", null: false
    t.index ["publication_id"], name: "publication_id"
    t.index ["series_id"], name: "series_id"
  end

  create_table "social_site_links", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "social_site_id", null: false
    t.integer "linkable_id", null: false
    t.string "linkable_type", limit: 7, default: "Feature", null: false
    t.string "link_path", null: false
    t.string "active", limit: 8, default: "active", null: false
    t.datetime "created_at", null: false
    t.timestamp "updated_at", null: false
    t.index ["social_site_id"], name: "social_site_id"
  end

  create_table "social_sites", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.string "uri_name", null: false
    t.string "active", limit: 8, default: "active", null: false
    t.datetime "created_at", null: false
    t.timestamp "updated_at", null: false
  end

  create_table "syndicate_features", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "feature_id", null: false
    t.integer "syndicate_id", null: false
    t.string "code", limit: 32, null: false
    t.string "active", limit: 8, default: "active", null: false
    t.datetime "created_at", null: false
    t.timestamp "updated_at", null: false
    t.index ["code", "feature_id", "syndicate_id"], name: "idx_feature_code", unique: true
    t.index ["feature_id"], name: "feature_id"
    t.index ["syndicate_id"], name: "syndicate_id"
  end

  create_table "syndicates", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "code", limit: 16, null: false
    t.string "name", limit: 64, null: false
    t.datetime "created_at", null: false
    t.timestamp "updated_at", null: false
    t.index ["code"], name: "idx_syndicate_code", unique: true
    t.index ["name"], name: "idx_syndicate_name", unique: true
  end

  create_table "taggings", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "tag_id"
    t.integer "taggable_id", null: false
    t.string "taggable_type"
    t.boolean "display", default: true
    t.string "context"
    t.integer "tagger_id"
    t.string "tagger_type"
    t.datetime "created_at", null: false
    t.index ["tag_id", "taggable_type", "taggable_id", "context"], name: "tag_id", unique: true
    t.index ["tag_id"], name: "index_taggings_on_tag_id"
    t.index ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context"
    t.index ["tagger_id"], name: "index_taggings_on_tagger_id"
  end

  create_table "tags", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", limit: 128, null: false
    t.timestamp "updated_at", null: false
    t.integer "tag_count"
    t.index ["name"], name: "idx_tag_name", unique: true
  end

  create_table "test", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.timestamp "updated_at", null: false
  end

  create_table "text_components", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "asset_id", null: false
    t.string "title"
    t.text "content", limit: 16777215
    t.datetime "created_at", null: false
    t.timestamp "updated_at", null: false
    t.index ["asset_id"], name: "idx_text_component", unique: true
  end

  create_table "text_feature_transcripts", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.text "body"
    t.integer "publication_id"
    t.integer "feature_id"
    t.datetime "publish_date"
    t.index ["feature_id"], name: "index_text_feature_transcripts_on_feature_id"
    t.index ["publication_id"], name: "index_text_feature_transcripts_on_publication_id"
  end

  create_table "transcripts", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.integer "publication_id", null: false
    t.text "transcript_text"
    t.integer "user_id"
    t.index ["publication_id"], name: "index_transcripts_on_publication_id"
    t.index ["user_id"], name: "index_transcripts_on_user_id"
  end

  create_table "users", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "username", limit: 32, null: false
    t.string "first_name", limit: 64, null: false
    t.string "last_name", limit: 64, null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", limit: 128, default: "", null: false
    t.string "password_salt", default: "", null: false
    t.string "reset_password_token"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.integer "group_id", default: 12
    t.datetime "created_at", null: false
    t.timestamp "updated_at", null: false
    t.index ["group_id"], name: "group_id"
    t.index ["username"], name: "idx_username", unique: true
  end

  create_table "uu_ad_positions", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.integer "height"
    t.integer "width"
    t.datetime "created_at", null: false
    t.timestamp "updated_at", null: false
  end

  create_table "uu_ads", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "ad_position_id", null: false
    t.string "image_path", null: false
    t.string "url"
    t.datetime "created_at", null: false
    t.timestamp "updated_at", null: false
    t.index ["ad_position_id"], name: "ad_position_id"
  end

  create_table "uu_contacts", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "email_from"
    t.string "phone"
    t.string "company"
    t.string "city"
    t.string "state"
    t.string "subject"
    t.text "body"
    t.text "extras"
    t.string "email_to"
    t.integer "feature_id"
    t.string "attachment_path"
    t.datetime "created_at", null: false
    t.timestamp "updated_at", null: false
    t.index ["feature_id"], name: "feature_id"
  end

  create_table "uu_search_terms", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "term"
    t.integer "searched_count"
    t.string "redirect_url"
    t.datetime "created_at", null: false
    t.timestamp "updated_at", null: false
    t.index ["term"], name: "index_uu_search_terms_on_term", unique: true
  end

  create_table "website_features", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "feature_id", null: false
    t.integer "website_id", null: false
    t.date "activation_date"
    t.string "active", limit: 9, default: "inactive", null: false
    t.text "about"
    t.datetime "created_at", null: false
    t.timestamp "updated_at", null: false
    t.index ["feature_id", "website_id"], name: "idx_feature_website_id", unique: true
    t.index ["feature_id"], name: "feature_id"
    t.index ["website_id"], name: "website_id"
  end

  create_table "websites", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "code", null: false
    t.string "name", null: false
    t.string "uri_name", null: false
    t.datetime "created_at", null: false
    t.timestamp "updated_at", null: false
  end

  add_foreign_key "assets", "feature_depots", name: "assets_ibfk_2", on_update: :cascade, on_delete: :nullify
  add_foreign_key "assets", "features", name: "assets_ibfk_3", on_update: :cascade, on_delete: :cascade
  add_foreign_key "auxiliary_assets", "features", name: "auxiliary_assets_ibfk_1", on_update: :cascade, on_delete: :cascade
  add_foreign_key "creator_features", "creators", name: "creator_features_ibfk_1", on_update: :cascade
  add_foreign_key "creator_features", "features", name: "creator_features_ibfk_2", on_update: :cascade, on_delete: :cascade
  add_foreign_key "depots", "syndicates", name: "depots_ibfk_1", on_update: :cascade
  add_foreign_key "editors", "features", name: "editors_ibfk_1", on_update: :cascade, on_delete: :cascade
  add_foreign_key "editors", "users", name: "editors_ibfk_2", on_update: :cascade, on_delete: :cascade
  add_foreign_key "feature_depots", "depots", name: "feature_depots_ibfk_1", on_update: :cascade, on_delete: :cascade
  add_foreign_key "feature_depots", "features", name: "feature_depots_ibfk_2", on_update: :cascade, on_delete: :cascade
  add_foreign_key "feature_details", "features", name: "feature_details_ibfk_1", on_update: :cascade, on_delete: :cascade
  add_foreign_key "feature_watchers", "features", name: "feature_watchers_ibfk_1", on_update: :cascade, on_delete: :cascade
  add_foreign_key "feature_watchers", "users", name: "feature_watchers_ibfk_2", on_update: :cascade, on_delete: :cascade
  add_foreign_key "features", "languages", name: "features_ibfk_2", on_update: :cascade, on_delete: :nullify
  add_foreign_key "features", "syndicates", name: "features_ibfk_3", on_update: :cascade, on_delete: :nullify
  add_foreign_key "news_items", "features", name: "news_items_ibfk_1", on_update: :cascade, on_delete: :cascade
  add_foreign_key "oauth_access_tokens", "users", column: "resource_owner_id"
  add_foreign_key "process_details", "features", name: "process_details_ibfk_1", on_update: :cascade, on_delete: :cascade
  add_foreign_key "publications", "features", name: "publications_ibfk_1", on_update: :cascade, on_delete: :cascade
  add_foreign_key "puzzle_details", "features", name: "feature_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "series_publications", "publications", name: "series_publications_ibfk_2", on_update: :cascade, on_delete: :cascade
  add_foreign_key "series_publications", "series", name: "series_publications_ibfk_1", on_update: :cascade, on_delete: :cascade
  add_foreign_key "social_site_links", "social_sites", name: "social_site_links_ibfk_1", on_update: :cascade
  add_foreign_key "syndicate_features", "features", name: "syndicate_features_ibfk_1", on_update: :cascade, on_delete: :cascade
  add_foreign_key "syndicate_features", "syndicates", name: "syndicate_features_ibfk_2", on_update: :cascade, on_delete: :cascade
  add_foreign_key "taggings", "tags", name: "taggings_ibfk_1", on_update: :cascade, on_delete: :cascade
  add_foreign_key "text_components", "assets", name: "text_components_ibfk_1", on_update: :cascade, on_delete: :cascade
  add_foreign_key "users", "groups", name: "users_ibfk_1", on_update: :cascade
  add_foreign_key "uu_ads", "uu_ad_positions", column: "ad_position_id", name: "uu_ads_ibfk_1", on_update: :cascade
  add_foreign_key "website_features", "features", name: "website_features_ibfk_1", on_update: :cascade, on_delete: :cascade
  add_foreign_key "website_features", "websites", name: "website_features_ibfk_2", on_update: :cascade
end
