require 'rails_helper'

def set_host (host)
    default_url_options[:host] = host
end

RSpec.describe "Application", type: :request do
  describe "GET /" do

    before(:all) do
        set_host "localhost:3000"
    end

    it "returns http success on home" do

        
      # this will perform a GET request to the /health/index route
      get "/"
      
      # 'response' is a special object which contain HTTP response received after a request is sent
      # response.body is the body of the HTTP response, which here contain a JSON string
      expect(response.body).to eq('{"message":"Welcome to the API"}')
      
      # we can also check the http status of the response
      expect(response.status).to eq(200)
    end

    
  end
end