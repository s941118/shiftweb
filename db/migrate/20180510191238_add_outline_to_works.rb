class AddOutlineToWorks < ActiveRecord::Migration[5.2]
  def change
    add_column :works, :outline, :string
  end
end
