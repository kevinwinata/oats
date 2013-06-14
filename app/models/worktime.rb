# == Schema Information
#
# Table name: worktimes
#
#  id             :integer          not null, primary key
#  employee_id    :integer
#  checkin        :datetime
#  checkout       :datetime
#  place_checkin  :string(255)
#  place_checkout :string(255)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Worktime < ActiveRecord::Base
  attr_accessible :checkin, :checkout, :place_checkin, :place_checkout
  
  belongs_to :employee

  validates :employee_id, presence: true
  
  validates :place_checkin, presence: true, length: { maximum: 50 }
  validates :place_checkout, presence: true, length: { maximum: 50 }

end
