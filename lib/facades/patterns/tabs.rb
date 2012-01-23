module Facades
  module Patterns
    ##
    # Generates a tabbed container including 
    # a navigation as well as the tab's "panes"
    # 
    module Tabs
      
      def tabbed(options = {}, &block)
        TabBuilder.new(self, options).render(&block)
      end
      
      class TabBuilder
        attr_reader :view
        attr_accessor :options, :tabs
        
        def initialize(tpl, options = {})
          @view, @options, @tabs = tpl, options, []
        end
        
        delegate :content_tag, :concat, :link_to, :capture, :to => :view
        
        ##
        # Renders the resulting tab area 
        # including a list navigation.
        # 
        def render(&block)
          klasses = options.delete(:class) || ""
          options.merge!(:class => klasses.split(" ").push("tabbed").join(" "))          
          rendered = view.capture(self, &block)
          output   = content_tag(:ul, { :class =>'tab-navigation' }) do
            tabs.each_with_index do |tab, ind|
              link_opts = ( ind == 0 ? { :class => 'active' } : {} )
              concat content_tag(:li, link_to(tab.title, "##{tab.tab_id}"), link_opts)
            end
          end
          output << rendered
          concat content_tag(:div, output, options)
        end
        
        ##
        # Adds a new panel to the tabbed area.
        # @param [String] title The text to be used in the navigation link.
        # @param [Hash] options A hash of html attributes to be added to the tab panel.
        # 
        def panel(title, options = {}, &block)
          panel = TabPanel.new(title, options)
          tabs << panel
          concat content_tag(:section, capture(&block), panel.options)
        end
        
      end
      
      class TabPanel
        attr_accessor :options, :title
        
        def initialize(title, options = {})
          @title, @options = title, options
          @options.merge!(:id => tab_id)
          klasses = @options.delete(:class) || ""
          @options.merge!(:class => klasses.split(" ").push("tab").join(" "))
        end
        
        def tab_id
          return options[:id] if options[:id]
          value = title.mb_chars.normalize(:kd).gsub(/[^\x00-\x7F]/n, '').to_s
          value.gsub(/[']+/, '').gsub(/\W+/, ' ').strip.downcase.gsub(" ", "_")
        end
        
      end
      
      
    end # Tabs
  end # Patterns
end # Facades