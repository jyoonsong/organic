class CreateTweets < ActiveRecord::Migration[5.2]
  def change
    create_table :tweets do |t|
      t.string :text
      t.string :ideology
      t.string :author
      t.boolean :isfallacy

      t.timestamps
    end
  end
end
