class AddStatusToWorks < ActiveRecord::Migration[5.2]
  def change
    add_column :works, :status, :integer, default: 0
  end
end
