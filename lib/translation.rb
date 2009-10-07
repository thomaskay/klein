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
            
      def self.from_hash(locale, value, key = nil)
        keys = []        
        if value.instance_of?Hash
          value.each do |k,v|
            new_key = "#{(!key.nil??key+".":"")}#{k}"
            from_hash(locale, v, new_key)
          end
        else
          #value is not a hash, but an actual translation
          obj = self.find_by_key(key, :conditions => ["locale=?", locale]) #find existing
          obj = new({:locale=>locale,:key=>key,:text=>value}) if obj.nil? #or use new
          
          obj.text = value
          obj.save
        end
      end
    end
  end
end