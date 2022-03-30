module SessionHelper

    def retrieve_access_token
      set_host('localhost:3000')
      post '/api/users/login', params: {user: {email: "mails@mails.com", password: "password"}}
  
      expect(response.response_code).to eq 200
      parsed = JSON(response.body)
      parsed['token']
    end
end