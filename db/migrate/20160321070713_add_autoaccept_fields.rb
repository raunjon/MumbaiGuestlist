class AddAutoacceptFields < ActiveRecord::Migration
  def change
    remove_column(:users,:autoaccept)
    add_column :users, :autoaccept, :boolean, default: false
  end
end
