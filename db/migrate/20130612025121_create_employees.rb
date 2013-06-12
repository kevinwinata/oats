class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
      t.string :name
      t.string :mobile_number
      t.string :email
      t.string :division
      t.boolean :role

      t.timestamps
    end
  end
end
