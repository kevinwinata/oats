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
      before { click_button "Sign in" }
    end

    describe "with invalid information" do
      before { click_button "Sign in" }
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
        it { should have_link('Sign in') }
      end
    end
  end
end
