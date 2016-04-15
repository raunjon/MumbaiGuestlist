class AddEnabledBool < ActiveRecord::Migration
  def change
    add_column :clubs, :enabled, :boolean, default: true
  end
end
