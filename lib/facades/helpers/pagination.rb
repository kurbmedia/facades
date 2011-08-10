module Facades
  module Helpers

    module Pagination
      
      class PageLink
        attr_reader :number
        attr_reader :current
        
        def initialize(num, curr)
          @number   = num
          @current = curr
        end
        
        def current?
          current === true
        end
    
      end
      
      class Paginator
        
        attr_reader :current_page
        attr_reader :total_pages
        attr_reader :attributes
        attr_reader :links        
        
        def initialize(collection, view, request)
          @total_pages  = collection.total_pages
          @current_page = collection.current_page
          @links        = []
          @template     = view
          @request      = request
        end
        
        def paginate!(window)
          window.each do |page|            
            @links << PageLink.new(page, (page == current_page))
          end
        end
        
        def first?
          current_page == 1
        end
        
        def last?
          (current_page == total_pages)
        end
        
        def next
          links.detect{ |l| l.number == current_page + 1 }
        end
        
        def previous
          links.detect{ |l| l.number == current_page - 1 }          
        end
        
        def link(page_number, attrs = {}, text = nil)
          text ||= page_number
          options = CGI.parse(@request.query_string).merge('page' => page_number)
          @template.link_to(text.to_s.html_safe, "?#{options.to_query}", attrs)
        end
        
      end
      
      def paginate(collection, html_attrs = {}, file = "facades/pagination")
        
        return "" if collection.total_count <= 0
        paginator    = Paginator.new(collection, self, request)        
        window_min   = [(paginator.current_page - 5), 1].max
        window_max   = [(paginator.current_page + 5), paginator.total_pages].min
        wrapper      = Facades.enable_html5 ? :nav : :div
        
        paginator.paginate!((window_min..window_max).to_a)
        contents = render(partial: file, locals: { paginator: paginator })
        
        content_tag(wrapper, contents.html_safe, class: 'pagination')
      end

    end   
      
  end
end