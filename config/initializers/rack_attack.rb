class Rack::Attack
  cache.store = ActiveSupport::Cache::MemoryStore.new

  safelist("allow from localhost") do |req|
    req.ip == "127.0.0.1"
  end

  throttle("req/ip", limit: 300, period: 4.minute) do |req|
    req.ip unless req.path.start_with?('/assets')
  end

  throttle("logins/ip", limit: 3, period: 1.minute) do |req|
    req.post? && req.path == "/api/v1/users/login" && req.ip
  end
end
