class CreatePreferences < ActiveRecord::Migration
  def change
    create_table :preferences, id: false do |t|
    	t.primary_key :user_id
    	t.string :name
        t.string :zip
        t.string :province
        t.string :city
        t.string :street
        t.string :house_number
        t.float  :latitude
        t.float  :longitude

    	t.timestamps null: false
    end
  end
end
