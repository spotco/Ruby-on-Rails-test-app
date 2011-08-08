require 'spec_helper'

describe "LayoutLinks" do
	it "have homepage at '/'" do
		get '/'
		response.should be_success
	end
	
	it "have contact page at '/contact'" do
		get '/contact'
		response.should be_success
	end
	
	it "should have aboout page at /about" do
		get '/about'
		response.should be_success
	end
end
