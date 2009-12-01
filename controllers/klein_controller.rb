class KleinController < ActionController::Base

  layout 'klein'


  def index
    @total_translation_keys = I18n::Backend::Translation.count(:key,:distinct=>true)
    
#render :text => "Squawk!"
  end
  
  def translate
    
  end

  def filter
    
    
  end



end

