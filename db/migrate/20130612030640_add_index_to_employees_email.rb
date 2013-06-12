class AddIndexToEmployeesEmail < ActiveRecord::Migration
  def change
  	add_index :employees, :email, unique: true
  	add_index :employees, :mobile_number, unique: true
  end
end
