class Worktime < ActiveRecord::Base
  attr_accessible :checkin, :checkout, :place_checkin, :place_checkout
  
  belongs_to :employee

  validates :employee_id, presence: true
  
  validates :place_checkin, presence: true, length: { maximum: 50 }
  validates :place_checkout, presence: true, length: { maximum: 50 }

end