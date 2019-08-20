class CreateSurveytasks < ActiveRecord::Migration[5.2]
  def change
    create_table :surveytasks do |t|
      
      t.string :kind
      t.string :classification
      t.string :question
      t.string :options
      t.integer :answer

      t.belongs_to :task, foreign_key: true

      t.timestamps
    end

    change_column :surveytasks, :answer, :integer, :null => true
  end
end
