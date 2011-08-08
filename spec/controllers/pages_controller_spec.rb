require 'spec_helper'

describe PagesController do
  render_views
	
  describe "GET 'home'" do
    it "home should be successful" do
      get 'home'
      response.should be_success
    end
	
  end

  describe "GET 'contact'" do
    it "contact should be successful" do
      get 'contact'
      response.should be_success
    end
  end
  
   describe "GET 'about'" do
    it "about should be successful" do
      get 'about'
      response.should be_success
    end
  end

end
