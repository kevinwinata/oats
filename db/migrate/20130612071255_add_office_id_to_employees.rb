class AddOfficeIdToEmployees < ActiveRecord::Migration
  def change
    add_column :employees, :office_id, :integer
  end
end
