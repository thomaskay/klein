module I18n  
  module Backend  
    class KleinBackend < Simple  

      def load_from_db  
        puts "loading from db"
        
        map = {}
        
        I18n::Backend::Translation.find(:all).each do |t|
          locale = t.locale.to_sym
                    
          map[locale] = {} unless map[locale]
          merge_translations(locale, t.to_hash)
        end
      end 

      protected  
  
      def init_translations  
        load_from_db
        @initialized = true  
      end  
      
    end  
  end  
end