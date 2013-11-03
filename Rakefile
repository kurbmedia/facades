require 'bundler/gem_tasks'
require "rspec"
require "rspec/core/rake_task"

load File.join( File.expand_path("../", __FILE__), 'src', 'icons', 'generator.rake')

RSpec::Core::RakeTask.new("spec") do |spec|
  spec.pattern = "spec/**/*_spec.rb"
end

task :default => :spec