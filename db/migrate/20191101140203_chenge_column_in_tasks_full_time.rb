class ChengeColumnInTasksFullTime < ActiveRecord::Migration[5.2]
  def up
    remove_column :tasks, :end_time
  end

  def down
    add_column :tasks, :end_time, :datetime
  end
end
