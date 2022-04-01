# Be sure to restart your server when you modify this file.

# Avoid CORS issues when API is called from the frontend app.
# Handle Cross-Origin Resource Sharing (CORS) in order to accept cross-origin AJAX requests.

# Read more: https://github.com/cyu/rack-cors

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins "example.com"

    resource "*",
      headers: :any,
      methods: [:get, :post]
  end
end



if ENV['SERVER_MODE'] == 'staging' || ENV['SERVER_MODE'] == 'production'
    Rails.application.config.hosts << ("ruby-challenge-#{ENV['SERVER_MODE']}.herokuapp.com")
  
else
    Rails.application.config.hosts << "localhost:3000"
    Rails.application.config.hosts << "www.example.com"
end