class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.integer :project_id
      t.integer :user_id
      t.time :end_time
      t.string :description

      t.timestamps
    end
  end
end
