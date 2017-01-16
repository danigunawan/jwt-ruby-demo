class JsonWebToken
  def self.encode(payload)
  	JWT.encode payload, Rails.application.secrets.JWT_SECRET, "HS256"
  end

  def self.decode(access_token)
  	JWT.decode access_token, Rails.application.secrets.JWT_SECRET, true, { :algorithm => 'HS256' }
  end
end