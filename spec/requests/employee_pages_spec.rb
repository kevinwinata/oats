require 'spec_helper'

describe "Employee pages" do

  subject { page }

  describe "signup" do

    before { visit "/employee/signup" }

    let(:submit) { "Create my account" }
    let(:office) { FactoryGirl.create(:office) }

    describe "with invalid information" do
      it "should not create an employee" do
        expect { click_button submit }.not_to change(Employee, :count)
      end
    end
  end
  describe "edit" do
    let(:employee) { FactoryGirl.create(:employee) }
    before do
      employee_sign_in employee
      visit edit_employee_path(employee)
    end
   
    describe "with valid information" do
      before do
        fill_in "Old password",     with: "1234567"
        fill_in "New password",     with: "kwimba"
        fill_in "Confirmation", with: "kwimba"
        click_button "Save changes"
      end

      specify { employee.reload.password.should  == "kwimba" }
    end
  end
end