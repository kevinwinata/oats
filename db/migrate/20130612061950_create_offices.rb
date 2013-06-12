class CreateOffices < ActiveRecord::Migration
  def change
    create_table :offices do |t|
      t.string :name
      t.float :longitude
      t.float :latitude

      t.timestamps
    end
  end
end
