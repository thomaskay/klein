namespace :klein do
  namespace :db do
    desc "Creates translation table migration for use with Klein"
    task :create => :environment do
      require 'rails_generator'
      require 'rails_generator/scripts/generate'

      if ActiveRecord::Base.connection.supports_migrations?
        Rails::Generator::Scripts::Generate.new.run(["translation_table","add_translation_table"])
      else
        raise "Task unavailable to this database (no migration support)"
      end
    end
  end
end
