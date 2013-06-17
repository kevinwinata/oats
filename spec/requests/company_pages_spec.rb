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

  describe "profile page" do
    let(:company) { FactoryGirl.create(:company) }
    before do
      visit '/company/signin'
      fill_in "Username",    with: company.username
      fill_in "Password", with: company.password
      click_button "Sign in"
      cookies[:remember_company] = company.remember_company
      @o1 = company.offices.build(latitude:-90,longitude:-180,name:"Blah")
      @o1.save
      @e1 = @o1.employees.build(email: "oteng@email.com", name: "Mario", division: "IT", mobile_number: "2378947283", password: "1234567", password_confirmation: "1234567")
      @e1.save
      @o2 = company.offices.build(latitude:-90,longitude:-180,name:"Shit")
      @o2.save
      @e2 = @o2.employees.build(email: "abc@email.com", name: "Abc", division: "IT", mobile_number: "237894283", password: "1234567", password_confirmation: "1234567")
      @e2.save
      visit company_path(company)
    end

    it { should have_content(company.username) }

    describe "office" do
      it { should have_content(@o1.name) }
      it { should have_content(@o2.name) }
      it { should have_content(company.offices.count) }
    end

    describe "employee" do
      it { should have_content(@e1.email) }
      it { should have_content(@e2.email) }
      it { should have_content('2') }
    end
  end
end
