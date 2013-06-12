class AddIndexToCompaniesUsername < ActiveRecord::Migration
  def change
  	add_index :companies, :username, unique: true
  	add_index :companies, :email, unique: true
  end
end
