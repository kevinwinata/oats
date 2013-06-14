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

  describe "edit" do
    let(:company) { FactoryGirl.create(:company) }
    before do
      visit '/company/signin'
      fill_in "Username",    with: company.username
      fill_in "Password", with: company.password
      click_button "Sign in"
      cookies[:remember_company] = company.remember_company
      visit edit_company_path(company)
    end

    describe "page" do
      it { should have_selector('h1',    text: "Update company profile") }
      it { should have_selector('title', text: "Edit company") }
    end

    describe "with invalid information" do
      before { click_button "Save changes" }
        it { should have_selector('h1',    text: "Update company profile") }
        it { should have_selector('title', text: "Edit company") }
    end

    describe "with valid information" do
      before do
        fill_in "Address",          with: "sdkfklasfjaofjioa"
        fill_in "Contact",          with: "893437"
        fill_in "Email",            with: "sun@dragoon.com"
        fill_in "Name",             with: "Adriel"
        fill_in "Password",         with: "4561237"
        fill_in "Confirm Password", with: "4561237"
        click_button "Save changes"
      end

      it { should have_content("Adriel") }
      it { should have_link('Sign out') }
      specify { company.reload.name.should  == "Adriel" }
    end
  end
end
