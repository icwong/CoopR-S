class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles, id: false do |t|
      t.primary_key :user_id
      t.string :first_name
      t.string :middle_name
      t.string :last_name
      t.string :phone

      t.timestamps null: false
    end
  end
end
