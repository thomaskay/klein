module I18n  
  module Backend  
    class KleinBackend < Simple  
      protected  
  
      def init_translations  
        load_from_db
        @initialized = true  
      end  
      
      def load_from_db  
        map = {}
        
        I18n::Backend::Translation.find(:all).each do |t|
          locale = t.locale.to_sym
                    
          map[locale] = {} unless map[locale]
          merge_translations(locale, t.to_hash)
        end
      end 
    end  
  end  
end