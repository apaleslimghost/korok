module ApplicationHelper
   def extends(layout, &block)
      layout = layout.to_s
      layout = "layouts/#{layout}" unless layout.include?('/')
      @view_flow.get(:layout).replace capture(&block)
      render template: layout
    end
end
