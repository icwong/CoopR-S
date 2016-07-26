class InitialSchema < ActiveRecord::Migration
  def change
    
    create_table :resumes do |t|
      t.string :name
      t.text   :summary
      t.string :phone
      t.string :email
      t.string :gitweb
      t.string :workname
      t.string :workrole
      t.string :workwhen
      t.string :workloc
      t.string :workinfo
      t.string :projtitle
      t.string :projrole
      t.string :projwhen
      t.string :edudeg
      t.string :eduloc
      t.string :eduuni
      t.string :eduwhen
      t.string :gpa
      t.string :skill
    end
    
    create_table :categories do |t|
      t.string :name
    end
    
  end
end
