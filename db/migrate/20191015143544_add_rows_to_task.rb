class AddRowsToTask < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :name, :string
    add_column :tasks, :task_completed, :boolean
  end
end
