class AddCompanyIdToOffices < ActiveRecord::Migration
  def change
    add_column :offices, :company_id, :integer
  end
end
