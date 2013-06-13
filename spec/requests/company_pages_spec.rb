require 'spec_helper'

describe "company pages" do

  subject { page }

  describe "signup" do

    before { visit '/company/signup' }

    let(:submit) { "Create my account" }

    describe "with invalid information" do
      it "should not create a company" do
        expect { click_button submit }.not_to change(Company, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in "Username",     with: "company"
        fill_in "Name",         with: "Example company"
        fill_in "Email",        with: "company@example.com"
        fill_in "Password",     with: "foobar"
        fill_in "Confirmation", with: "foobar"
      end

      it "should create a company" do
        expect { click_button submit }.to change(Company, :count).by(1)
      end
    end
  end
end
