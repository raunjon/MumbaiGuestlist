class EditUsers < ActiveRecord::Migration
  def change
    remove_column(:users,:title)
    remove_column(:users,:passwordr)
    add_column(:users,:username, :string)
    add_column(:users,:password, :string)
  end
end