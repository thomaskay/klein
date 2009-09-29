class <%= class_name %> < ActiveRecord::Migration
  def self.up
    create_table :translations, :force => true do |t|
      t.string :locale
      t.string :key
      t.string :text
    end
  end

  def self.down
    drop_table :translations
  end
end
