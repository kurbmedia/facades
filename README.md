Facades
=================

Facades is a framework, written in SASS (.scss) designed to assist with front-end development rapid prototyping. It includes a number of base classes, patterns and mixins, 
focused on semantic html, and styled around a consistent vertical rhythm.

**Another one? Come on**
Theres tons of css / rapid dev frameworks around, and some pretty awesome ones. Facades doesn't re-invent the wheel.. instead we've combined the best parts of 
some of the best frameworks around such as [Twitter's Bootstrap](http://bootstrap.io) and [foundation](http://foundation.zurb.com), and optimized them 
for HTML5 and a clean baseline

**Why not just use one of the existing frameworks then?**
There were/are a number of things about the frameworks listed above (and any others we've utilized) we felt weren't quite 'up to par', but that didn't mean 
they weren't still great.  Instead of implementing multiple divs and non-semantic elements, facades utlizes HTML5 elements and css3, while 
keeping support for IE7+, plus recent versions of Webkit and Firefox.

Facades also utilizes SASS mixins for patterns and ui-specific elements, providing more flexiblity in implementation. For instance, 
the notifications pattern (alerts/flash messages) is implemented as a mixin, allowing the developer to decide their own node and class 
scheme to use. This makes facades easier to implement in existing projects, without having to change existing classes or html format.

When implementing patterns color schemes are provided as an option, for those instances where you'd prefer your own class names and color schemes.

For those who just want to import and go, theres also a `_globals.scss` which creates all of the defaults, with classes and all. To utilize import it into your main css file.

``` scss	
@import 'facades/global';
```

If you'd like to configure any particular variables such as sizes or line heights, do so before importing the global file.

Reset and Configuration
------------------------------

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

Contributing
------------------------------

Fork and create. When coding styles or ruby libs, adhere to a 2 space indention. Patterns should be written as mixins, with a 
default class construction in `_global.scss`. Colors should be configurable, either by using one of the colors included in `_config.scss` 
(preferred) or by 'namespaced' variable (ie: $patternname-border-color). 

Pre-built classes / styles should be as lightweight as possible and avoid css hacks. We encourage support of Paul Irish's class conventions 
found [here](http://paulirish.com/2008/conditional-stylesheets-vs-css-hacks-answer-neither/). CSS overrides for IE should utilize this technique. 
Styles should confirm to a vertical-rhythm as much as possible (some things seem to always be off a hair in IE (who would have thought)).

Document patterns with html examples, which should utilize HTML5 elements, in an intended/semantic manner. 

Thanks
------------------------------

Thanks to Twitter, Zurb, The fine folks who work on the HTML5 Boilerplate, the Compass library and contributors, and the hundreds of 
random people who've blogged the tons and tons of google search results we've read in creating this library.

Licence
------------------------------

Copyright 2012 kurb media llc. 
MIT/GPL ( do whatever you want, but check the licenses below )

**Components:**

Twitter Bootstrap: AL2
Zurb Foundation: MIT license
jQuery: MIT/GPL license
HTML5 Boilerplate reset.css: Public Domain
