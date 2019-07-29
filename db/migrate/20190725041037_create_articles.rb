class CreateArticles < ActiveRecord::Migration[5.2]
  def change
    create_table :articles do |t|
      t.string :topic
      t.string :subtopic
      t.string :title
      t.text :metadata
      t.text :content
      t.integer :expert_score

      t.timestamps
    end
  end
end
