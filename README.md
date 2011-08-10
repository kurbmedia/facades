#Facades
Facades is a gem designed to assist with front-end development and misc design. It includes a compass plugin / mixins, and various Rails view helpers to help with common development tasks. 

##CSS / SASS
Facades includes several mixins and includes for setting up a few defaults within your css. 

###Reset
A HTML5-friendly reset is included to ensure elements like `aside`, `section` etc are setup properly. It also sets up a few typography defaults using Compass' vertical-rhythm format.
To configure, assign the variables to `$font-size` and `$line-height`.  These will default to 12px / 24px. Vertical-rhythm is defaulted to relative font sizes.

	$font-size:12px;
	$line-height:24px;
	
	@import 'facades/reset';  // Will automatically setup the vertical rhythm

###Layout
Mixins are provided for a fixed grid, forms, and grid debugging. 

**Grid Setup**
	
	$grid-width: 960px; 		// Full width of the container
	$grid-columns: 24; 			// Total number of columns
	$grid-gutter-width: 10px;	// Spacing between each column
	
	@import 'facades/layout/grid'; /( or include 'facades/layout')
	#wrapper{ @include container; }

To debug grid alignment, a shortcut to the Compass' grid background is provided.

	#wrapper{ @include debug-grid; }

### Mixins
Below is a list of available mixins
	
	Interface
	-----------------------
	tool-tip
	flash-message
	flash-message-colors
	
	Forms
	----------------------
	form-field-list
	form-split-field-list
	form-field
	form-input
	form-select
	form-textarea
	form-errors
	form-error-message
	form-field-hint
	
	Grid (based off of the blueprint grid)
	---------------------
	column
	push
	pull
	append
	prepend
	span (function) // width:span(2);
	
	Text
	----------------------
	leading (shortcut to Compass adjust-leading-to)
	font-size (shortcut to Compass adjust-font-size-to)
	inset-text (text-shadow text insetting)
	
	Utility
	----------------------
	position (shorthand position relative/fixed/absolute)
	luminance ( return a colors lightness in terms of 'light' or 'dark' )
	tint (tint a color with white)
	shade (darken a color with black)
	
##Helpers

###Layout Helpers

**Variables**
Setup variables via templates to be used within your layout. 

* `page_id` The id of the current page, useful for targeting with CSS. Defaults to "controller_action" in Rails
* `page_title` Used to populate the title of the page
* `keywords` Used to populate the keywords meta tag
* `description` Used to populate the description meta tag

To assign variables, pass their value to the method. To display, use the method without any arguments
	
	# index.html.erb
	<%= page_id('home') %>
	
	# In your layout
	body id="<%= page_id %>"
	
**Misc**

`meta_tag` A shortcut for creating HTML meta tags. 

	<%= meta_tag('name', 'content') %> #=> <meta name="name" content="content" />
	
`robot_meta_tag` A shortcut for defining a robot meta tag based on the Rails.env. Useful to keep spiders out of your staging environments

	# In any environment but production
	<%= robot_meta_tag %> #=> <meta name="robots" content="noindex, nofollow" />
	
	# In production
	<%= robot_meta_tag %> #=> <meta name="robots" content="index, follow" />
	
`button_link` Shortcut for creating a link class="button" with an optional icon

	<%= button_link 'Link Text', some_path, icon: 'image.png' %>  #=> <a href='#' class='button'><img src='image.png' /></a>
	
###Pagination Helper

Any model which responds to current_page and total_pages can utilize the pagination helper. 

	<%= paginate(collection) %>
	
Will render a link based list with the current collection pagination. If `Facades.enable_html5` is set to `true` items will be wrapped in a HTMl5 `<nav>` tag, otherwise a div  will be used. The class 'pagination' is added to that top level element. 
By default the included partial facades/pagination is rendered. To customize output simply override this in your application. See app/views/facades/_pagination.html.erb for more info.

###Navigation Helper

Facades provides a navigation helper for creating nested navigation lists. 

	<%= nav do %>
		<%= nav_link 'About Me', about_path %>
		<%= nav_link 'Top Level', some_path do %>
			<%= nav_link 'Sub Item', some_sub_path %>
		<% end %>
	<% end %>
	
Will output

	<nav>
		<ol>
			<li><a href='/about-path'>About Me</a></li>
			<li><a href='/some-path'>Top Level</a>
				<ol>
					<li><a href="/some-sub-path">Sub Item</a></li>
				</ol>
			</li>
		</ol>
	</nav>

Note: The `<nav>` tag is only included if `Facades.enable_html5` is set to true.
	
As a convenience, the class `on` will be added to a link when the current url matches that link. This can be overridden by using the `matcher` or `proc` attributes when calling `nav_link`.
When using a proc/lambda, returning true will set the `on` class.

	# Current path /home
	<%= nav_link 'Path', some_path, proc: lambda{ |current_path| true } %> #=> <a href='/anything' class='on'>Path</a>
	
When using `:matcher`, pass a string or regular expression in which the request.path should match to be `on`.
	
	# Current path /somewhere
	<%= nav_link 'Path', '/something-else', matcher: /somewhere/ %> #=> <a href='/something-else' class='on'>Path</a>
	
