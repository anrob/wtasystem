class MenuTabBuilder < TabsOnRails::Tabs::Builder
  def tab_for(tab, name, options, item_options = {})
    item_options[:class] = 'dashboard no-submenu'
    
    @context.content_tag(:li) do
      @context.link_to(name, options, {:class => "dashboard no-submenu"})
    end
  end
end