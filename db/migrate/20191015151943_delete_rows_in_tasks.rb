class DeleteRowsInTasks < ActiveRecord::Migration[5.2]
  def change
    remove_column :tasks, :name
    remove_column :tasks, :task_completed
  end
end
