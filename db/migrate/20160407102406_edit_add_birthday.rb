class EditAddBirthday < ActiveRecord::Migration
  def change
    remove_column :users, :birthdate
    add_column :users, :birthday, :string
  end
end
