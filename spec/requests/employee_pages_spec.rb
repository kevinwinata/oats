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
        select 1, :from => 'office_id'
      end

      it "should create an employee" do
        expect { click_button submit }.to change(Employee, :count).by(1)
      end
    end
  end
end