# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "facades/version"

Gem::Specification.new do |s|
  s.name        = "facades"
  s.version     = Facades::VERSION
  s.authors     = ["Brent Kirby"]
  s.email       = ["brent@kurbmedia.com"]
  s.homepage    = "https://github.com/kurbmedia/facades"
  s.summary     = %q{Front-end development awesome-ness with Compass and Sass.}
  s.description = %q{Facades is a collection of front-end patterns and libraries designed to speed up development of web sites and applications.}

  s.rubyforge_project = "facades"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  
  s.add_dependency('sass', ['~> 3.1'])
  s.add_dependency('compass', ['>= 0.11.7'])
  
  s.add_development_dependency('combustion', '~> 0.3.1')
  s.add_development_dependency("rspec", ">= 2.7.0")
  s.add_development_dependency("rspec-rails", ">= 2.7.0")
  
end
