class ChangeWorkDateToDate < ActiveRecord::Migration[5.2]
  def change
  	change_column :works, :work_date, :date
  end
end
