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
          if(text.first == '[' && text.last == ']' ) #handle arrays
            evaluated = text[1..-2].split(',').collect!{|n|n.strip}
            evaluated.collect!{|n| (n.first==":" ? n.slice(/[^:].*/).to_sym : n  )} #handle symbols
          else
            evaluated = text
          end

          return {name => evaluated}
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
          if value.instance_of?Array
            value = "[#{value.map{|v|(v.instance_of?Symbol)?":#{v.to_s}":v.to_s}.join(',')}]";
          end
          obj = self.find_or_create_by_key(key, :locale => locale)
          obj.locale = locale 
          obj.text = value
          obj.save
        end
      end      
    end
  end
end