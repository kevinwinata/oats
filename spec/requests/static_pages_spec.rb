require 'spec_helper'

describe "StaticPages" do

  subject { page }

  shared_examples_for "all static pages" do
    it { should_not have_selector('header') }
    it { should have_selector('footer') }
    it { should have_selector('h1', text: heading) }
    it { should have_selector('title', text: page_title) }
  end

  describe "Home page" do
    before { visit '/static_pages/home' }
    let(:heading){''}
    let(:page_title){''}
    it_should_behave_like "all static pages"
    it { should_not have_selector 'h1', text: 'Home' }
    it { should have_selector 'title', text: 'Home' }
  end

  describe "About page" do
    before { visit '/static_pages/about' }
    let(:heading){'About Us'}
    let(:page_title){'About Us'}
    it_should_behave_like "all static pages"
  end

  describe "Contact page" do
  	before { visit '/static_pages/contact' }
    let(:heading){'Contact Us'}
    let(:page_title){'Contact Us'}
    it_should_behave_like "all static pages"
  end

  describe "Terms of Service page" do
    before { visit '/static_pages/terms' }
    let(:heading){'Terms of Service'}
    let(:page_title){'Terms of Service'}
    it_should_behave_like "all static pages"
  end

  describe "Privacy of Policy page" do
    before { visit '/static_pages/privacy' }
    let(:heading){'Privacy of Policy'}
    let(:page_title){'Privacy of Policy'}
    it_should_behave_like "all static pages"
  end

  describe "Clients and Testimony page" do
    before { visit '/static_pages/clientsandtestimony' }
    let(:heading){'Clients and Testimony'}
    let(:page_title){'Clients and Testimony'}
    it_should_behave_like "all static pages"
  end

  describe "Help page" do
    before { visit '/static_pages/help' }
    let(:heading){'Help'}
    let(:page_title){'Help'}
    it_should_behave_like "all static pages"
  end

end
