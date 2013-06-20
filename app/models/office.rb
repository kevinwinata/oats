# == Schema Information
#
# Table name: offices
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  longitude  :float
#  latitude   :float
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  company_id :integer
#

class Office < ActiveRecord::Base
  attr_accessible :latitude, :latitude_min, :latitude_max, :longitude, :longitude_min, :longitude_max, :name, :range
  has_many :employees, dependent: :destroy
  belongs_to :company

  validates :company_id, presence: true
  validates :name, presence: true, length: { maximum: 50 }
  validates :latitude, presence: true, :numericality => {:greater_than_or_equal_to => -90, 
  														 :less_than_or_equal_to => 90}
  validates :longitude, presence: true, :numericality => {:greater_than_or_equal_to => -180, 
  														 :less_than_or_equal_to => 180}
  validates :latitude_min, :numericality => {:greater_than_or_equal_to => -90, 
  														 :less_than_or_equal_to => 90}
  validates :longitude_min, :numericality => {:greater_than_or_equal_to => -180, 
  														 :less_than_or_equal_to => 180}
  validates :latitude_max, :numericality => {:greater_than_or_equal_to => -90, 
  														 :less_than_or_equal_to => 90}
  validates :longitude_max, :numericality => {:greater_than_or_equal_to => -180, 
  														 :less_than_or_equal_to => 180}	
  validates :range, presence: true													 																											 
end
