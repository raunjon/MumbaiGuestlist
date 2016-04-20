class AddInstaLocidToClubs < ActiveRecord::Migration
  def change
    add_column :clubs, :instagram_location_id, :string
  end
end
