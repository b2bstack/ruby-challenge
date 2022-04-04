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
        
      get "/"
      
      expect(response.body).to eq('{"message":"Welcome to the API"}')
      expect(response.status).to eq(200)
    end

    
  end
end