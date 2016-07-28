class CreateAuthentications < ActiveRecord::Migration
  def change
    create_table :authentications, id: false do |t|
      t.primary_key :user_id
      t.boolean :pass, default: false
      t.string :serial


      t.timestamps null: false
    end
  end
end
