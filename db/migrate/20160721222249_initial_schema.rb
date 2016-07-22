class InitialSchema < ActiveRecord::Migration
  def change
    
    create_table :resumes do |t|
      t.string :name
      t.text   :d
      t.string :address
      t.string :city
      t.string :state
      t.string :zipcode
      t.string :phone
      t.string :email
      t.string :gitweb
      t.string :cmpyname
      t.string :cmpywhere
      t.string :cmpywhen
      t.string :cmpyrole
      t.string :cmpyinfo
      t.string :projtitle
      t.string :projrole
      t.string :edudeg
      t.string :eduloc
      t.string :eduuni
      t.string :eduwhen
      t.string :gpa
    end
    
    create_table :categories do |t|
      t.string :name
    end
    
    
  end
end
