require 'spec_helper'

describe "Authentication" do

  subject { page }

  describe "signin page" do
    before { visit '/company/signin' }

    it { should have_selector('h1',    text: 'Sign in') }
    it { should have_selector('title', text: 'Sign in') }
  end

  describe "signin" do
    before { visit '/company/signin' }

    describe "with invalid information" do
      before do
        click_button "Sign in"
      end
      it { should have_content("Sign in") }
    end

    describe "with valid information" do
      let(:company) { FactoryGirl.create(:company) }
      before do
        fill_in "Username",    with: company.username.upcase
        fill_in "Password", with: company.password
        click_button "Sign in"
      end

      it { should have_content(company.username) }
      describe "after saving the user" do
        it { should have_link('Sign out') }
      end

      describe "followed by signout" do
        before { click_link "Sign out" }
        it { should have_content("Sign in") }
      end
    end
  end

  describe "authorization" do

    describe "for non-signed-in companies" do
      let(:company) { FactoryGirl.create(:company) }

      describe "when attempting to visit a protected page" do
        before do
          visit edit_company_path(company)
          fill_in "Username",    with: company.username
          fill_in "Password", with: company.password
          click_button "Sign in"
        end

        describe "after signing in" do

          it "should render the desired protected page" do
            page.should have_content("Update company profile")
          end
        end
      end

      describe "in the Offices controller" do

        describe "submitting to the create action" do
          before { post offices_path }
          specify { response.should redirect_to('/company/signin') }
        end

        describe "submitting to the destroy action" do
          before { delete office_path(FactoryGirl.create(:office)) }
          specify { response.should redirect_to('/company/signin') }
        end
      end

      describe "in the Companies controller" do

        describe "visiting the edit page" do
          before { visit edit_company_path(company) }
          it { should have_content('Sign in') }
        end

        describe "submitting to the update action" do
          before { put company_path(company) }
          specify { response.should redirect_to('/company/signin') }
        end
      end
    end

    describe "as wrong company" do
      let(:company) { FactoryGirl.create(:company) }
      let(:wrong_company) { FactoryGirl.create(:company, username: "adriel", email: "sun@dragoon.com") }
      before do
        visit '/company/signin'
        fill_in "Username",    with: company.username
        fill_in "Password", with: company.password
        click_button "Sign in"
        cookies[:remember_company] = company.remember_company
      end

      describe "visiting Companies#edit page" do
        before { visit edit_company_path(wrong_company) }
        it { should_not have_content("Update company profile") }
      end

      describe "submitting a PUT request to the Users#update action" do
        before { put company_path(wrong_company) }
        specify { response.should redirect_to(company_path(company)) }
      end
    end
  end
end
