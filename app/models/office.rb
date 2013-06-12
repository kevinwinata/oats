class Office < ActiveRecord::Base
  attr_accessible :latitude, :longitude, :name
  has_many :employees
  belongs_to :company

  validates :company_id, presence: true
  validates :name, presence: true, length: { maximum: 50 }
  validates :latitude, presence: true, :numericality => {:greater_than_or_equal_to => -90, 
  														 :less_than_or_equal_to => 90}
  validates :longitude, presence: true, :numericality => {:greater_than_or_equal_to => -180, 
  														 :less_than_or_equal_to => 180}
end
