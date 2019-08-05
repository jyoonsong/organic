class CreateAnswers < ActiveRecord::Migration[5.2]
  def change
    create_table :answers do |t|
      t.string :value
      t.integer :time
      t.integer :preference
      t.integer :capability

      t.belongs_to :article, foreign_key: true
      t.belongs_to :task, foreign_key: true
      t.belongs_to :user, foreign_key: true

      t.timestamps
    end

    change_column :answers, :preference, :integer, :null => true
    change_column :answers, :capability, :integer, :null => true

  end
end
