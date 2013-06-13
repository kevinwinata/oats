class AddRememberCompanyToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :remember_company, :string
    add_index  :companies, :remember_company
  end
end
