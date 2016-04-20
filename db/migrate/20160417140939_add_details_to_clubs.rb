class AddDetailsToClubs < ActiveRecord::Migration
  def change
    add_column :clubs, :description, :string
    add_column :clubs, :address, :string
    add_column :clubs, :latitude, :float
    add_column :clubs, :longitude, :float
    add_column :clubs, :club_policy, :string
    add_column :clubs, :twitter_handle, :string
    add_column :clubs, :insta_handle, :string
    add_column :clubs, :hashtag, :string
  end
end
