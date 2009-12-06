ActiveRecord::Schema.define(:version => 0) do
  create_table :translations, :force => true do |t|
    t.string :locale
    t.string :key
    t.string :text
  end
end