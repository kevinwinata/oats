class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :username
      t.string :name
      t.string :address
      t.string :email
      t.string :contact

      t.timestamps
    end
  end
end
