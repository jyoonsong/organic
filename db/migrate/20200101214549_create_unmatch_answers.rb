class CreateUnmatchAnswers < ActiveRecord::Migration[5.2]
  def change
    create_table :unmatch_answers do |t|
      t.string :reason
      t.boolean :isfallacy
      t.integer :time

      t.belongs_to :tweet, foreign_key: true
      t.belongs_to :user, foreign_key: true
      t.timestamps
    end

    change_column :unmatch_answers, :reason, :string, :null => true
    change_column :unmatch_answers, :isfallacy, :boolean, :null => true
    change_column :unmatch_answers, :time, :integer, :null => true
  end
end
