class CreateSms < ActiveRecord::Migration
  def change
    create_table :sms do |t|
        t.string :number
    end
  end
end
