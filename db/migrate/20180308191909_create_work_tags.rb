class CreateWorkTags < ActiveRecord::Migration[5.2]
  def change
    create_table :work_tags do |t|
      t.belongs_to :tag, foreign_key: true
      t.belongs_to :work, foreign_key: true

      t.timestamps
    end
  end
end