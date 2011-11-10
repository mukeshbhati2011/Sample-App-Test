require 'spec_helper'

describe PagesController do

  # Test Views also
  render_views
  
  # Common Varible across each test as it is executed everytime before a test
  before(:each) do
	@baseTitle = "Ruby on Rails Tutorial Sample App |"
  end
  
  
  describe "GET 'home'" do
    it "should be successful" do
      get 'home'
      response.should be_success
    end
	
	it "should have the right title" do
		get 'home'
		response.should have_selector("title",
						:content =>	@baseTitle + " Home")
	end
	
  end

  describe "GET 'contact'" do
    it "should be successful" do
      get 'contact'
      response.should be_success
    end
	
	it "should have the right title" do
      get 'contact'
      response.should have_selector("title",
                        :content => @baseTitle + " Contact")
    end

  end

  describe "GET 'about'" do
	it "should be successful" do
	    get 'about'
		response.should be_success
	end
	
	it "should have the right title" do
      get 'about'
      response.should have_selector("title",
                        :content => @baseTitle + " About")
    end

  end	
  
  # Test case for the Help Action.
  describe "GET 'help'" do
	it "should be successful" do
		get 'help'
		response.should be_success
	end
	
	it "should have the right title" do
		get 'help'
		response.should have_selector("title",
						:content => @baseTitle + " Help")
	end
	
  end	
end
