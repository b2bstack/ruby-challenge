class JsonWebToken
  SUPER_SECRET_KEY = Rails.application.secrets.secret_key_base.freeze

  def self.encode(payload, exp = 10.hours.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, SUPER_SECRET_KEY)
  end

  def self.decode(token)
    decoded = JWT.decode(token, SUPER_SECRET_KEY)[0]
    HashWithIndifferentAccess.new decoded
  end
end
