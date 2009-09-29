module I18n  
  module Backend

    class Translation < ActiveRecord::Base
    
      def path
        key.split('.').slice(0..-2)
      end
  
      def name
        key.split('.').last
      end
      
      def to_hash
        hasher(path)

      end
      
      def hasher(path)
        if path.length == 0
          return {name => text}
        end
        hash = {}        
        hash[path.first] = hasher(path.slice(1..-1) )
        hash
      end
    end
  end
end