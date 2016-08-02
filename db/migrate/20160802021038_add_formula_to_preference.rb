class AddFormulaToPreference < ActiveRecord::Migration
  def change
    add_column :preferences, :formula, :string
  end
end
