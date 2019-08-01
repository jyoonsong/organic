class CreateAnswers < ActiveRecord::Migration[5.2]
  def change
    create_table :answers do |t|
      t.string :value
      t.integer :time
      t.integer :preference
      t.integer :capability

      t.timestamps
    end
  end
end
