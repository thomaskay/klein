

namespace :klein do

  desc "Creates translation table migration for use with Klein"
  task :setup do
    require 'rails_generator'
    require 'rails_generator/scripts/generate'

    if ActiveRecord::Base.connection.supports_migrations?
      Rails::Generator::Scripts::Generate.new.run(["translation_table","add_translation_table"])
    else
      raise "Task unavailable to this database (no migration support)"
    end
  end
  
  desc "Import translations from a yaml file"
  task :import => [:environment] do 
    require 'translation'
    yaml_file = ENV['yaml_file']
    
    unless yaml_file
      puts "\nMissing yamlfile\n\n"
      puts "Specify with:"
      puts "rake klein:import yaml_file='tmp/da.yml'\n\n"
      exit
    end
    yaml = YAML::load(File.open(yaml_file))
        
    yaml.each do |node|
      locale = node[0]
      hash = node[1]
      I18n::Backend::Translation.from_hash(locale, hash)
    end
  end
end
