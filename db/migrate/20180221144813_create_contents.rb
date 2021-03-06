class CreateContents < ActiveRecord::Migration[5.2]
  def change
    create_table :contents do |t|
      t.text :html
      t.text :processed_html
      t.belongs_to :work, foreign_key: true
      t.integer :ordering
      t.string :wrapper_klass
      t.integer :usage, default: 0

      t.timestamps
    end
  end
end
