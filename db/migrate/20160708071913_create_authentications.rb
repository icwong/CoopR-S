class CreateAuthentications < ActiveRecord::Migration
  def change
    create_table :authentications, id: false do |t|
      t.integer :user_id, index: true
      t.boolean :pass
      t.date :approved_date
      t.date :applied_date


      t.timestamps null: false
    end

    add_index :change, :approved_date
    add_index :change, :applied_date
  end
end
