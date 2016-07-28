class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.integer :owner, index: true
      t.integer :status
      t.string :title
      t.text :body
      t.string :type

      t.timestamps null: false
    end
  end
end
