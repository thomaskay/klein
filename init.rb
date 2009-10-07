require 'klein_backend'
require 'translation'
require "routing"

%w{ models controllers helpers}.each do |dir|
  path = File.join(File.dirname(__FILE__), dir)
  $LOAD_PATH << path
  ActiveSupport::Dependencies.load_paths << path
  ActiveSupport::Dependencies.load_once_paths.delete(path)
end

path = File.join(File.dirname(__FILE__), 'views')
ActionController::Base.append_view_path(path)  
