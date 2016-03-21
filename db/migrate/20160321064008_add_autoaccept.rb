class AddAutoaccept < ActiveRecord::Migration
  def change
    add_column :users, :autoaccept, :boolean, default: false
  end
end
