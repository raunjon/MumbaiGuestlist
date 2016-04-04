class AddSource < ActiveRecord::Migration
  def change
    add_column :guestlists, :source, :string
    add_column :users, :gender, :string
    add_column :users, :push_id, :string
  end
end
