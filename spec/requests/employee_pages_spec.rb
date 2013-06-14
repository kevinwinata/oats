require 'spec_helper'

describe "Employee pages" do

  subject { page }

  describe "signup" do

    before { visit "/employee/signup" }

    let(:submit) { "Create my account" }

    describe "with invalid information" do
      it "should not create an employee" do
        expect { click_button submit }.not_to change(Employee, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in "Name",     with: "wilson fonda"
        fill_in "Email",        with: "user@example.com"
        fill_in "Division",     with: "IT"
        fill_in "Mobile number",     with: "380128390"
        fill_in "Password",     with: "foobar"
        fill_in "Confirmation", with: "foobar"
        select 1, :from => "Office"
      end

      it "should create an employee" do
        expect { click_button submit }.to change(Employee, :count).by(1)
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
      let(:new_name)  { "New Name" }
      let(:new_division) { "Pegawai" }
      let(:new_mobile) { "08192834738" }
      before do
        fill_in "Name",             with: new_name
        fill_in "Division",     with: new_division
        fill_in "Mobile number",     with: new_mobile
        click_button "Save changes"
      end

      specify { employee.reload.name.should  == new_name }
      specify { employee.reload.division.should == new_division }
      specify { employee.reload.mobile_number.should == new_mobile }
    end
  end
end