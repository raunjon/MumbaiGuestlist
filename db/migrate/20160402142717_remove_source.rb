class RemoveSource < ActiveRecord::Migration
  def change
    change_column :guestlists, :source, :integer
  end
end
