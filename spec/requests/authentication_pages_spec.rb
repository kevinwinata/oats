require 'spec_helper'

describe "AuthenticationPages" do
  describe "signin" do
    before { visit '/employee/signin' }

    describe "with valid information" do
      let(:employee) { FactoryGirl.create(:employee) }
      before do
        fill_in "Email",    with: employee.email.upcase
        fill_in "Password", with: employee.password
        click_button "Sign in"
      end
    end
  end
end
