class AddUserToPreference < ActiveRecord::Migration
  def change
    add_reference :preferences, :user, index: true, foreign_key: true
  end
end
