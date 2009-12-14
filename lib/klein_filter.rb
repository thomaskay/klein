module Klein
  class KleinFilter 
    USERNAME = "admin"
    PASSWORD = "d033e22ae348aeb5660fc2140aec35850c4da997" # = admin
    def self.filter(controller) 
      controller.authenticate_or_request_with_http_basic do |username, password| 
        username == USERNAME && Digest::SHA1.hexdigest(password) == PASSWORD 
      end  
    end
  end
end



