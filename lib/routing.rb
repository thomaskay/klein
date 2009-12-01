module Klein #:nodoc:
  module Routing #:nodoc:
    module MapperExtensions
      def klein
        @set.add_route("/klein/translate", {:controller => "klein", :action => "translate"})        
        @set.add_route("/klein/filter", {:controller => "klein", :action => "filter"})        
        @set.add_route("/klein", {:controller => "klein", :action => "index"})        
      end
    end
  end
end

ActionController::Routing::RouteSet::Mapper.send :include, Klein::Routing::MapperExtensions