require 'spec_helper'

describe "Office pages" do

  subject { page }

  let(:company) { FactoryGirl.create(:company) }
  before do
    visit '/company/signin'
    fill_in "Username",    with: company.username
    fill_in "Password", with: company.password
    click_button "Sign in"
    cookies[:remember_company] = company.remember_company
  end

  describe "office creation" do
    before { visit edit_company_path(company) }

    describe "with invalid information" do

      it "should not create a office" do
        expect { click_button "Add" }.not_to change(Office, :count)
      end
    end

    describe "with valid information" do

      before do
        fill_in 'office_name', with: "Lorem ipsum"
        fill_in 'office_latitude', with: "34"
        fill_in 'office_longitude', with: "56"
      end
      it "should create a office" do
        expect { click_button "Add" }.to change(Office, :count).by(1)
      end
    end
  end

  describe "office destruction" do
    before { FactoryGirl.create(:office, company: company) }

    describe "as correct company" do
      before { visit company_path(company) }

      it "should delete a office" do
        expect { click_link "delete" }.to change(Office, :count).by(-1)
      end
    end
  end
end
