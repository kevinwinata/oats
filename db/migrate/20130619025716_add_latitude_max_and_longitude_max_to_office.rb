class AddLatitudeMaxAndLongitudeMaxToOffice < ActiveRecord::Migration
  def change
  	add_column :offices, :latitude_min, :float
  	add_column :offices, :longitude_min, :float
  	add_column :offices, :latitude_max, :float
  	add_column :offices, :longitude_max, :float
  	add_column :offices, :range, :float
  end
end
