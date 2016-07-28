class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs  do |t|
      t.integer :offered_by, index: true
      t.integer :working_hours
      t.integer :work_day
      t.integer :salary
      t.string :job_title

      t.timestamps null: false
    end
  end
end
