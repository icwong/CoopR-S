class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :namef
      t.string :namem
      t.string :namel
      t.string :zip
      t.string :province
      t.string :city
      t.string :street
      t.string :number
      t.string :phone

      t.timestamps null: false
    end
  end
end
