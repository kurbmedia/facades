# Facades
Facades is a framework, written in SASS (.scss) designed to assist with front-end development rapid prototyping. It includes a number of base classes, patterns and mixins, 
focused on semantic html, and styled around a consistent vertical rhythm. 

**Another one? Come on**
Theres tons of css / rapid dev frameworks around, and some pretty awesome ones including  [Twitter's Bootstrap](http://bootstrap.io) and [foundation](http://foundation.zurb.com). We took inspiration from 
each of these to create a more standards based solution writtenfor HTML5 and designed around a clean baseline rhythm.

**Why not just use one of the existing frameworks then?**
We wanted something that was more standards friendly where at all possible, and felt as though a lot of what was out there missed the mark. We've
utilized the concepts that worked, and scrapped a few that didn't. Keeping a clean vertical rhythm was also important, which 
wasn't available with anything existing at the time.

Facades also utilizes the fantastic [Compass](https://github.com/chriseppstein/compass) library to add additional function and flexiblity. 
This helps increase the functionality and reliability of the framework as a whole.

Most of the patterns included here are written using sass mixins, with configuration options for fonts, sizes, and colors. For instance, the notifications pattern (alerts/flash messages) is implemented as a mixin, allowing the developer to decide their own node and class 
scheme to use. This makes facades easier to implement in existing projects, without having to change existing classes or html format.

When implementing patterns color schemes are provided as an option, for those instances where you'd prefer your own class names and design.

For those who just want to import and go, theres also a `_globals.scss` which creates all of the defaults, with classes and all. To utilize, import it into your main css file.

```scss
@import 'facades/global';
```

If you'd like to configure any particular variables such as sizes or line heights, do so before importing the global file.

## Reset and Configuration

Facades implements the awesome [HTML5 Boilerplate](https://github.com/h5bp/html5-boilerplate) reset/normalize stylesheet to establish a 
grounds for which to expand upon. Common colors, sizes and line-heights are fully configurable using the variables found in `_config.scss`. 
The more common options you probably want to configure are:

`$font-color`: The body/default font color.
`$font-size`: The base font size, also used when calculating vertical rhythm
`$line-height`: The base line-height, combined with `$font-size` establishes a baseline and sets up the vertical-rhythm
`$font-family`: The base font-family
`$notice-color`: The color used for .notice alerts labels, blue by default
`$success-color`: The color used for .success labels and alerts, green by default
`$error-color`: The color used for :invalid fields, .error labels and alerts, red by default
`$warning-color`: The color used for .warning labels and alerts, yellow by default
`$input-border-color`: The default color used for form elements, grey by default.
`$input-focus-color`: The font color used when an input is focused, defaults to `$font-color`
`$input-focus-border-color`: The border color used for inputs when in a :focus state. Defaults to `$notice-color`
`$input-error-color`: The font color used for inputs in an :invalid or .error state. Defaults to red.
`$input-error-border-color`: The border color used for inputs in an :invalid or .error state. Defaults to `$error-color`.

## View Helpers

### Variables
Setup variables via templates to be used within your layout. 

* `page_id` The id of the current page, useful for targeting with CSS. Defaults to "controller_action" in Rails
* `page_title` Used to populate the title of the page
* `keywords` Used to populate the keywords meta tag
* `description` Used to populate the description meta tag

To assign variables, pass their value to the method. To display, use the method without any arguments

```erb
# index.html.erb
<% page_id('home') %>	
```
```erb
# In your layout
<body id="<%= page_id %>">
```

### Misc

`meta_tag` A shortcut for creating HTML meta tags. 

```erb
<%= meta_tag('name', 'content') %> #=> <meta name="name" content="content" />
```

`robot_meta_tag` A shortcut for defining a robot meta tag based on the Rails.env. Useful to keep spiders out of your staging environments

```erb
# In any environment but production
<%= robot_meta_tag %> #=> <meta name="robots" content="noindex, nofollow" />	
# In production
<%= robot_meta_tag %> #=> <meta name="robots" content="index, follow" />
```
	
`browser_name` Returns the name of the user's browser (ie webkit, mozilla, ie8, ie9, etc)

### Navigation Helpers

Facades provides a navigation helper for creating nested navigation lists. Syntax is similar to other Rails helpers such as `form_for`

```erb
<%= nav do |n| %>
    <%= n.link 'About Me', about_path %>
    <%= n.link 'Top Level', some_path do |s| %>
        <%= s.link 'Sub Item', some_sub_path %>
    <% end %>
<% end %>
```
	
Will output
```html
<nav>
    <ul>
        <li><a href='/about-path'>About Me</a></li>
        <li><a href='/some-path'>Top Level</a>
            <ul>
                <li><a href="/some-sub-path">Sub Item</a></li>
            </ul>
        </li>
    </ul>
</nav>
```
Note: The `<nav>` tag is only included if `Facades.enable_html5` is set to true.

As a convenience, the class `active` will be added to a link when the current url matches that link. This can be overridden by using one of three ways:
1. Assigning a `:proc` attribute. When using a proc/lambda, returning true will set the `active` class.
  
```erb
# Current path /home
<%= n.link 'Path', some_path, proc: lambda{ |current_path| true } %> #=> <a href='/anything' class='active'>Path</a>
```
  
2. Passing a `:match` attribute as one of `:exact`, `:after`, or `:before` will match all urls based on that formula. `:exact` matches only the exact
   url defined in the link's href attribute. `:before` matches any path matching a "parent" url, while `:after` matches any url starting with the specified path. 
   The latter is useful for when you'd like to match sub-pages or paths in nested navigations.  
   
3. Assigning a `:matcher` attribute, containing a regular expression in which the request.path should match to be `active`.

```erb	
<%= n.link 'Path', '/something-else', matcher: /something/ %> #=> <a href='/something-else' class='active'>Path</a>
```
  
In addition to the `nav` helper, a `nav_link` helper is also provided, for use when creating single links, which should also track 'active' state.


## Contributing

Fork and create. When coding styles or ruby libs, adhere to a 2 space indention. Patterns should be written as mixins, with a 
default class construction in `_global.scss`. Colors should be configurable, either by using one of the colors included in `_config.scss` 
(preferred) or by 'namespaced' variable (ie: $patternname-border-color). 

Pre-built classes / styles should be as lightweight as possible and avoid css hacks. We encourage support of Paul Irish's class conventions 
found [here](http://paulirish.com/2008/conditional-stylesheets-vs-css-hacks-answer-neither/). CSS overrides for IE should utilize this technique. 
Styles should confirm to a vertical-rhythm as much as possible (some things seem to always be off a hair in IE (who would have thought)).

Document patterns with html examples, which should utilize HTML5 elements, in an intended/semantic manner. 

## Changelog

**1.0.1 - October 12, 2012**

*   Add additional configuration options for input padding
*   Add configuration option for transitions specifically on inputs
*   misc style cleanup, modifications to html output of notifications

## Thanks

Thanks to the fine folks who work on the HTML5 Boilerplate, the Compass library and contributors, and the hundreds of 
random people who've blogged the tons and tons of google search results we've read in creating this library.

## License

Copyright 2012 kurb media llc. 
MIT/GPL ( do whatever you want, but check the licenses below )

## Components:

Compass: MIT (modified)
HTML5 Boilerplate reset.css: Public Domain