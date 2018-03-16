class CreateTags < ActiveRecord::Migration[5.2]
  def change
    create_table :tags do |t|
      t.string :name
      t.integer :posts_count, default: 0
      t.boolean :shown_on_front, default: false

      t.timestamps
    end
  end
end
