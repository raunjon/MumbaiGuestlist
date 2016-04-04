class RemoveSource < ActiveRecord::Migration
  def change
    remove_column :guestlists, :source
    add_column :guestlists, :source, :integer, default: 0
  end
end
