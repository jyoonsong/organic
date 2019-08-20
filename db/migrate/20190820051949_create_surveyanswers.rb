class CreateSurveyanswers < ActiveRecord::Migration[5.2]
  def change
    create_table :surveyanswers do |t|

      t.string :value
      t.string :value_reason

      t.belongs_to :user, foreign_key: true
      t.belongs_to :surveytask, foreign_key: true

      t.timestamps
    end

    change_column :surveyanswers, :value_reason, :string, :null => true
  end
end
