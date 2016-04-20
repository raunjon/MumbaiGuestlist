class CreateFeed < ActiveRecord::Migration
  def change
    create_table :feeds do |t|
      t.string :twitter_id
      t.string :twitter_handle
      t.string :instagram_id
      t.string :instagram_handle
      t.string :instagram_location
      t.integer :club_id
    end
  end
end
