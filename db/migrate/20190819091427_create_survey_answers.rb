class CreateSurveyAnswers < ActiveRecord::Migration[5.2]
  def change
    create_table :survey_answers do |t|

      t.integer :value
      t.string :value_reason

      t.timestamps
    end

    change_column :survey_answers, :preference_reason, :string, :null => true

  end
end
