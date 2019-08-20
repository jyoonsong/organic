class CreateSurveyTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :survey_tasks do |t|

      t.string :kind
      t.string :classification
      t.string :question
      t.string :options
      t.integer :answer
      t.integer :relevant_task

      t.timestamps
    end

    change_column :survey_tasks, :answer, :integer, :null => true
    change_column :survey_tasks, :relevant_task, :integer, :null => true
  end
end
