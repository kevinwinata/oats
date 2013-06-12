# == Schema Information
#
# Table name: companies
#
#  id              :integer          not null, primary key
#  username        :string(255)
#  name            :string(255)
#  address         :string(255)
#  email           :string(255)
#  contact         :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string(255)
#

class Company < ActiveRecord::Base
  attr_accessible :address, :contact, :email, :name, :username,  :password, :password_confirmation
  has_secure_password

  before_save { |company| company.username = username.downcase }
  before_save { |company| company.email = email.downcase }

  validates :username, presence: true, uniqueness: { case_sensitive: false }, length: { maximum: 25 }
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true
end
