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
	
	Utility
	----------------------
	position (shorthand position relative/fixed/absolute)
	