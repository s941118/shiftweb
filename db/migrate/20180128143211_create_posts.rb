class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
    	t.string :number
      t.string :title
      t.string :category
      t.string :top_tags
      t.integer :tags_count, default: 0

      t.timestamps
    end
  end
end