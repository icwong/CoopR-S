class Coverletter < ActiveRecord::Migration
  def change
    
    create_table :coverletters do |t|
      t.string :name
      t.text   :summary
      t.string :phone
      t.string :email
      t.string :gitweb
    end
    
  end
end
