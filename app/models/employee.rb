# == Schema Information
#
# Table name: employees
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  mobile_number   :string(255)
#  email           :string(255)
#  division        :string(255)
#  role            :boolean
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string(255)
#  office_id       :integer
#  remember_token  :string(255)
#

class Employee < ActiveRecord::Base
  attr_accessible :name, :email,  :division, :mobile_number, :password, :password_confirmation, :office_id, :role

  has_secure_password

  has_many :worktimes, dependent: :destroy
  belongs_to :office

  before_save { |employee| employee.email = email.downcase }
  before_save :create_remember_token

  validates :office_id, presence: true
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :mobile_number, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true

  def checkin?(employee)
    w = Worktime.find_by_employee_id(employee, :limit => 1, :order => 'created_at desc')
    unless (w.nil?)
      !w.checkin.nil? && w.checkout.nil?
    end
  end

  def self.valid_password?(pass, conf)
    return (pass.to_s.length > 5 && pass.to_s == conf.to_s)
  end

  def self.valid_name?(name)
    return (name.to_s.length < 51 && name.to_s.length > 0)
  end

  def self.valid_mobile_number?(employee,number)
    return (!Employee.exists?(:mobile_number => number.to_s) || number.to_s == employee.mobile_number.to_s) && (number.to_s.length > 0)
  end

  def self.valid_office_id?(employee,office_id)
    return Company.find(Office.find(office_id).company_id) == Company.find(Office.find(employee.office_id).company_id)
  end

  private

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
end
