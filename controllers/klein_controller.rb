class KleinController < ActionController::Base
  before_filter Klein::KleinFilter
  
  layout 'klein'

  def index
    if params[:locale]
      @locale = params[:locale]
      @includes = params[:includes]
      @filter = params[:filter]    
    
      query = "1=1"
      query += " AND (`key` like '%#{@filter}%' OR text like '%#{@filter}%')" unless @filter.empty?

      @translations = I18n::Backend::Translation.find(:all, :conditions=> query + " AND locale = '#{@locale}'" )
      @default_translations = I18n::Backend::Translation.find(:all, :conditions=> query + " AND locale = '#{I18n.default_locale.to_s}'")

      @default_translations_keys = @default_translations.collect{|e|e.key}
      @translations_keys = @translations.collect{|e|e.key}      

      @translations_hash = Hash.new
      @translations.each{|e| @translations_hash[e.key]=e}

      @default_translations_hash = Hash.new
      @default_translations.each{|e| @default_translations_hash[e.key]=e}

      if @includes == 'Translated'
        @keys = @default_translations_keys & @translations_keys
      elsif @includes == 'Untranslated'
        @keys = @default_translations_keys - @translations_keys
      else
        @keys = @default_translations_keys
      end
    end
    
  end
  
  def skip
        
  end

  def save
    id = params[:id]
    locale = params[:locale]
    text = params[:text]
    
    default_translation = I18n::Backend::Translation.find(id)
    
    t = I18n::Backend::Translation.find_or_create_by_key_and_locale(:key => default_translation.key, :locale => locale)
    t.key = default_translation.key
    t.locale = locale
    t.text = text
    t.save
    
    render :json=>{:status=>'ok'}
  end
  
  def new
    @translation = I18n::Backend::Translation.new
  end
  
  def create
    @translation = I18n::Backend::Translation.new(params[:translation])
    @translation.locale = I18n.default_locale.to_s
    if @translation.save
      flash[:notice] = 'Translation saved'
      redirect_to :action => 'new'
    else
      render :action => 'new'
    end
  end  
  
  def flush
    I18n.backend.load_from_db
    flash[:notice] = 'Translations flushed'
    redirect_to :action => 'index'
  end
  
  

end

