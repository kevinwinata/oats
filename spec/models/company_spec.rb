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

require 'spec_helper'

describe Company do
  before do
    @company = Company.new(username: "Oteng", name: "Mario Orlando", email: "mario@example.com", 
    					   contact: "0819812492174", address: "Pisang 21", password: "1234567", password_confirmation: "1234567")
  end

  subject { @company }

  it { should respond_to(:username) }
  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:authenticate) }

  it { should be_valid }

  describe "when username is not present" do
    before { @company.username = " " }
    it { should_not be_valid }
  end

  describe "when username address is already taken" do
    before do
      company_with_same_username = @company.dup
      company_with_same_username.username = @company.username.upcase
      company_with_same_username.save
    end

    it { should_not be_valid }
  end

  describe "when email is not present" do
    before { @company.email = " " }
    it { should_not be_valid }
  end

  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[company@foo,com company_at_foo.org example.company@foo.
                     foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        @company.email = invalid_address
        @company.should_not be_valid
      end      
    end
  end

  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[company@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @company.email = valid_address
        @company.should be_valid
      end      
    end
  end

  describe "when email address is already taken" do
    before do
      company_with_same_email = @company.dup
      company_with_same_email.email = @company.email.upcase
      company_with_same_email.save
    end

    it { should_not be_valid }
  end

  describe "when name is not present" do
    before { @company.name = " " }
    it { should_not be_valid }
  end

  describe "when name is too long" do
    before { @company.name = "a" * 51 }
    it { should_not be_valid }
  end

  describe "when password is not present" do
    before { @company.password = @company.password_confirmation = " " }
    it { should_not be_valid }
  end

  describe "when password doesn't match confirmation" do
    before { @company.password_confirmation = "mismatch" }
    it { should_not be_valid }
  end

  describe "when password confirmation is nil" do
    before { @company.password_confirmation = nil }
    it { should_not be_valid }
  end

  describe "with a password that's too short" do
    before { @company.password = @company.password_confirmation = "a" * 5 }
    it { should be_invalid }
  end

  describe "return value of authenticate method" do
    before { @company.save }
    let(:found_company) { Company.find_by_username(@company.username) }

    describe "with valid password" do
      it { should == found_company.authenticate(@company.password) }
    end

    describe "with invalid password" do
      let(:company_for_invalid_password) { found_company.authenticate("invalid") }

      it { should_not == company_for_invalid_password }
      specify { company_for_invalid_password.should be_false }
    end
  end
end

