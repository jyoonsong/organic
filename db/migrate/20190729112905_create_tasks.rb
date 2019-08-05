class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :question
      t.string :kind
      t.string :options

      t.timestamps
    end

    change_column :tasks, :options, :string, :null => true
  end
end
