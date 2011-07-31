= Facades

Facades is a gem designed to assist with front-end development and misc design. It includes a compass plugin / mixins, and various Rails view helpers to help with 
common development tasks. 

== CSS / SASS

Facades includes several mixins and includes for setting up a few defaults within your css. 

=== Reset
A HTML5-friendly reset is included to ensure elements like `aside`, `section` etc are setup properly. It also sets up a few typography defaults using Compass' 
vertical-rhythm format.

To configure, assign the variables to `$font-size` and `$line-height`.  These will default to 12px / 24px. Vertical-rhythm is defaulted to relative font sizes.

=== Layout
Mixins are provided for a fixed grid, forms, and grid debugging. To setup a grid, `@include 'facades/layout/grid'` ( or simply `facades/layout`) and configure the following:

* `$grid-width` The full width of the container in which your layout resides (default 960px)
* `$grid-columns` The number of columns within the grid (default 24)
* `$grid-gutter-width` The spacing between each column (default 10px)

To debug grid alignment, a shortcut to the Compass' grid background is provided. `@include debug-grid;` into your container element to debug.

