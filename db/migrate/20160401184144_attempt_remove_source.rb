class AttemptRemoveSource < ActiveRecord::Migration
  def change
    remove_column :users,:source
  end
end
