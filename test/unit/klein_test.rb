require 'test/unit'

require 'rubygems'
require 'active_record'

require File.dirname(__FILE__) + '/../test_helper.rb'

class KleinTest < Test::Unit::TestCase
  load_schema

  I18n.backend = I18n::Backend::KleinBackend.new  
  I18n.default_locale = :en
    
  def test_schema_has_loaded_correctly
    assert_equal 4, I18n::Backend::Translation.all.length
  end

  def test_shows_correct_english_text
    I18n.locale = :en
    assert_equal 'Railroad', I18n.t('railroad')
  end

  def test_shows_correct_translated_text
    I18n.locale = :da
    assert_equal 'Jernbane', I18n.t('railroad')
  end

  def test_handles_translation_not_found
    I18n.locale = :da
    assert_equal "translation missing: da, train", I18n.t('train')
  end

  def test_handles_nonexisting_key
    I18n.locale = :en
    assert_equal "translation missing: en, wagon", I18n.t('wagon')
  end

  def test_handles_international_characters
    I18n.locale = :da
    assert_equal 'Jordbærgrød', I18n.t('chartest')
  end
end
