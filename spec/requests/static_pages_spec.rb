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
    before { visit '/home' }
    let(:heading){''}
    let(:page_title){'Home'}
    it_should_behave_like "all static pages"
    it { should_not have_selector 'h1', text: 'Home' }
    it { should have_link('Employee Login', href: '/employee/signin') }
    it { should have_link('Company Login', href: '/company/signin') }
    it { should have_link('Register', href: '/company/signup') }
    it { should have_selector("img[src='/assets/logo.png']") }
    it { should have_selector("img[src='/assets/Building.png']") }
  end

  describe "About page" do
    before { visit '/about' }
    let(:heading){'About Us'}
    let(:page_title){'About Us'}
    it_should_behave_like "all static pages"
    it { should have_selector('div.static_content') }
  end

  describe "Contact page" do
   before { visit '/contact' }
    let(:heading){'Contact Us'}
    let(:page_title){'Contact Us'}
    it_should_behave_like "all static pages"
    it { should have_selector('h2') }
  end

  describe "Terms of Service page" do
    before { visit '/terms' }
    let(:heading){'Terms of Service'}
    let(:page_title){'Terms of Service'}
    it_should_behave_like "all static pages"
    it { should have_selector('div.static_content') }
  end

  describe "Privacy of Policy page" do
    before { visit '/privacy' }
    let(:heading){'Privacy of Policy'}
    let(:page_title){'Privacy of Policy'}
    it_should_behave_like "all static pages"
    it { should have_selector('div.static_content') }
  end

  describe "Clients and Testimony page" do
    before { visit '/clientsandtestimony' }
    let(:heading){'Clients and Testimony'}
    let(:page_title){'Clients and Testimony'}
    it_should_behave_like "all static pages"
    it { should have_selector('div#clients_content') }
  end

  describe "Help page" do
    before { visit '/help' }
    let(:heading){'Help'}
    let(:page_title){'Help'}
    it_should_behave_like "all static pages"
    it { should have_selector('div#help_left') }
    it { should have_selector('div#help_right') }
  end

end