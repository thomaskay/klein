module Klein #:nodoc:
  module Routing #:nodoc:
    module MapperExtensions
      def klein
        @set.add_route("/klein/new", {:controller => "klein", :action => "new"})
        @set.add_route("/klein/create", {:controller => "klein", :action => "create"})
        @set.add_route("/klein/save", {:controller => "klein", :action => "save"})
        @set.add_route("/klein/skip", {:controller => "klein", :action => "skip"})
        @set.add_route("/klein", {:controller => "klein", :action => "index"})
      end
    end
  end
end

ActionController::Routing::RouteSet::Mapper.send :include, Klein::Routing::MapperExtensions