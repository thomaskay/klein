require 'test/unit'

require 'rubygems'
require 'active_record'

require File.dirname(__FILE__) + '/../test_helper.rb'

class KleinTest < Test::Unit::TestCase
  load_schema

  I18n.backend = I18n::Backend::KleinBackend.new  
  I18n.default_locale = :en
    
  def test_schema_has_loaded_correctly
    assert_equal 3, I18n::Backend::Translation.all.length
  end

  def test_shows_correct_english_text
    I18n.locale = :en
    translated_text = I18n.t('railroad')
    assert_equal translated_text,  I18n::Backend::Translation.find_by_key('railroad',:conditions=>{:locale=>I18n.locale.to_s}).text
  end

  def test_shows_correct_translated_text
    I18n.locale = :da
    translated_text = I18n.t('railroad')
    assert_equal translated_text,  I18n::Backend::Translation.find_by_key('railroad',:conditions=>{:locale=>I18n.locale.to_s}).text
  end

  def test_handles_translation_not_found
    I18n.locale = :da
    translated_text = I18n.t('train')
    assert_equal translated_text, "translation missing: da, train"
  end

  def test_handles_nonexisting_key
    I18n.locale = :en
    translated_text = I18n.t('wagon')
    assert_equal translated_text, "translation missing: en, wagon"
  end



end
