class AddFeedIdToClubs < ActiveRecord::Migration
  def change
    add_column :clubs, :feed_id, :integer
  end
end
