class CreateClubs < ActiveRecord::Migration
  def change
    create_table :clubs do |t|
      t.string :title
    end
  end
end
