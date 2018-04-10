class CreateTags < ActiveRecord::Migration[5.2]
  def change
    create_table :tags do |t|
      t.string :name
      t.string :category
      t.string :job_title
      t.string :join_time
      t.integer :works_count, default: 0

      t.timestamps
    end
  end
end
