require 'spec_helper'

describe "Authentication" do
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

  describe "authorization" do
    describe "for non-signed-in employee" do
      let(:employee) { FactoryGirl.create(:employee) }

      describe "in the Users controller" do


        describe "submitting to the update action" do
          before { put employee_path(employee) }
          specify { response.should redirect_to('/employee/signin') }
        end
      end
    end

    describe "as wrong user" do
      let(:employee) { FactoryGirl.create(:employee) }
      let(:wrong_employee) { FactoryGirl.create( :wrong_employee) }
      before { employee_sign_in employee }

    end
  end
end
