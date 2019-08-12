class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :kind
      t.string :question
      t.string :options
      t.string :highlights
      t.string :constraints
      t.decimal :consensus, default: 1.0
      t.string :gold_task

      t.timestamps
    end

    change_column :tasks, :options, :string, :null => true
    change_column :tasks, :highlights, :string, :null => true
    change_column :tasks, :constraints, :string, :null => true
    change_column :tasks, :gold_task, :string, :null => true
    change_column :tasks, :consensus, :decimal, :null => true
  end
end
