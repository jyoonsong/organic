class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :key
      t.string :capability

      t.timestamps
    end
    change_column :users, :capability, :string, :null => true
    
  end
end
