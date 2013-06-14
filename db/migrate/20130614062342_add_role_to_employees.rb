class AddRoleToEmployees < ActiveRecord::Migration
  def change
    add_column :employees, :role, :boolean, default: false
  end
end
