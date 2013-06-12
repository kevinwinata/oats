# == Schema Information
#
# Table name: employees
#
#  id            :integer          not null, primary key
#  name          :string(255)
#  mobile_number :string(255)
#  email         :string(255)
#  division      :string(255)
#  role          :boolean
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Employee < ActiveRecord::Base
  attr_accessible :division, :email, :mobile_number, :name, :role, :password, :password_confirmation

  has_secure_password

  before_save { |employee| employee.email = email.downcase }

  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :mobile_number, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true
end
