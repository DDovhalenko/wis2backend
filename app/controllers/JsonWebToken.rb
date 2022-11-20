class JsonWebToken
    SECRET_KEY = 'e44922cf0acf1ca037249356f1bbe73acfbf5fa085d3f998c4f6146f914800e7966042a10b0b7e46363714db401ca3fdde72d52abf1957b33cb42ddb56fecf82'
  
    def self.encode(payload, exp = 24.hours.from_now)
      payload[:exp] = exp.to_i
      JWT.encode(payload, SECRET_KEY)
    end
  
    def self.decode(token)
      decoded = JWT.decode(token, SECRET_KEY)[0]
      HashWithIndifferentAccess.new decoded
    end
  end