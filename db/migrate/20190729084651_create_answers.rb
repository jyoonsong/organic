class CreateAnswers < ActiveRecord::Migration[5.2]
  def change
    create_table :answers do |t|
      t.string :value
      t.integer :time
      t.integer :preference
      t.integer :capability

      t.integer :article_id, foreign_key: true
      t.integer :task_id, foreign_key: true
      t.integer :user_id, foreign_key: true

      t.timestamps
    end
  end
end
