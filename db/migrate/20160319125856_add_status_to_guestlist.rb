class AddStatusToGuestlist < ActiveRecord::Migration
  def change
    add_column :guestlists, :status, :integer, default: 0
  end
end
