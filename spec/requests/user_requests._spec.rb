require 'rails_helper'

RSpec.describe "Users", type: :request do
  
  
  describe "GET /" do

    it "return http sucess on login" do
        get "/api/users/login"
        expect(response.body).to eq('{"message":"Enter email and password"}')
        expect(response.status).to eq(200)
    end

    it "return http sucess on register" do
        get "/api/users/sign_up"
        expect(response.body).to eq('{"message":"Enter email, username and password"}')
        expect(response.status).to eq(200)
    end

    it "return no routes metches on sign_out" do
        begin 

          get "/api/users/sign_out"
          expect(response.status).to_not eq(200)
        rescue ActionController::RoutingError => e


          expect(e).to be_a(ActionController::RoutingError)
        end
    end


  end


  describe "POST /" do

    before(:all) do
      @user1 = create(:user, email: 'mails@mail.com', username: 'user1', password: 'password', id: 2, created_at: '2022-03-29 17:56:40', updated_at: '2022-03-29 17:56:40')
    end

    let (:user_params) do 
      {
        user: {
          username: "test",
          email: "mail@mail.com",
          password: "password",
        }
      }
    end

    let (:login_params) do
      {
        user: {
          email: "mails@mail.com",
          password: "password",
        }
      }
    end

    it "return error on sign_up with null params" do
      post "/api/users"
      expect(response.body).to eq({errors: "You have not signed up" }.to_json)
     
    end

    it "return http sucess on sign_up with valid params" do
      post '/api/users', params: user_params
      expect(response.body).to eq({message: "You have successfully signed up, please activate your account by clicking the activation link that has been sent to your email address."}.to_json)

    end

    it "return email or password invalid on login with null params" do
      post "/api/users/login", params: {user: {email: "", password: ""}}
      expect(response.body).to eq( { errors: { 'email or password' => ['is invalid'] } }.to_json) 
    end

    it "return auth token on login with valid params" do
      post "/api/users/login", params: login_params
      if JSON.parse(response.body)["token"]
        token = JSON.parse(response.body)["token"]
      else
        token = ''
      end
      expect(response.body).to eq({ message: 'You have successfully logged in', token: token }.to_json)
    end

  end
end