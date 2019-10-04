class CreateProjects < ActiveRecord::Migration[5.2]
  def change
    create_table :projects do |t|
      t.integer :customer_id
      t.string :name
      t.string :description

      t.timestamps
    end
  end
end
