class DropColumnsFromClubs < ActiveRecord::Migration
  def change
    remove_column :clubs, :twitter_handle
    remove_column :clubs, :insta_handle
    remove_column :clubs, :hashtag
    remove_column :clubs, :instagram_location_id
    remove_column :clubs, :feed_id
    add_column :feeds, :hashtag, :string
  end
end
