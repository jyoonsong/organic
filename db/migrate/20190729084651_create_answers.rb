class CreateAnswers < ActiveRecord::Migration[5.2]
  def change
    create_table :answers do |t|
      t.string :value
      t.string :highlight
      t.integer :time
      t.integer :preference
      t.string :preference_reason
      t.boolean :finished, default: false

      t.belongs_to :article, foreign_key: true
      t.belongs_to :task, foreign_key: true
      t.belongs_to :user, foreign_key: true

      t.timestamps
    end

    change_column :answers, :value, :string, :null => true
    change_column :answers, :highlight, :string, :null => true
    change_column :answers, :time, :string, :null => true
    change_column :answers, :preference, :integer, :null => true
    change_column :answers, :preference_reason, :string, :null => true

  end
end
