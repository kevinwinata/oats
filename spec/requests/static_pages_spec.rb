require 'spec_helper'

describe "StaticPages" do

  describe "Home page" do
  end

  describe "About page" do
  	it "should have the content 'About Us'" do
  		visit '/static_pages/about'
  		page.should have_content('About Us')
  	end
  end

  describe "Contact page" do
  	it "should have the content 'Contact Us'" do
  		visit '/static_pages/contact'
  		page.should have_content('Contact Us')
  	end
  end

  describe "Terms of Service page" do
    it "should have the content 'Terms of Service'" do
      visit '/static_pages/terms'
      page.should have_content('Terms of Service')
    end
  end

  describe "Privacy of Policy page" do
    it "should have the content 'Privacy of Policy'" do
      visit '/static_pages/privacy'
      page.should have_content('Privacy of Policy')
    end
  end

  describe "Clients & Testimony page" do
    it "should have the content 'Clients & Testimony'" do
      visit '/static_pages/clientsandtestimony'
      page.should have_content('Clients and Testimony')
    end
  end

  describe "Help page" do
    it "should have the content 'Help'" do
      visit '/static_pages/help'
      page.should have_content('Help')
    end
  end

end
