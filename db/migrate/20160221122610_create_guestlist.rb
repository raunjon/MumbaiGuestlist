class CreateGuestlist < ActiveRecord::Migration
  def change
    create_table :guestlists do |t|
      t.integer :user_id
      t.integer :club_id
      t.string :mobile
      t.integer :couples
      t.date :entry_date
    end
  end
end
