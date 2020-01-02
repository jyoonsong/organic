class CreateTweetAnswers < ActiveRecord::Migration[5.2]
  def change
    create_table :tweet_answers do |t|
      t.integer :order
      t.boolean :isfallacy
      t.boolean :haveseen
      t.string :reason1
      t.string :reason2
      t.integer :time

      t.belongs_to :tweet, foreign_key: true
      t.belongs_to :user, foreign_key: true

      t.timestamps
    end

    change_column :tweet_answers, :order, :integer, :null => true
    change_column :tweet_answers, :isfallacy, :boolean, :null => true
    change_column :tweet_answers, :reason1, :string, :null => true
    change_column :tweet_answers, :reason2, :string, :null => true
    change_column :tweet_answers, :time, :integer, :null => true

  end
end
