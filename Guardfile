# A sample Guardfile
# More info at https://github.com/guard/guard#readme
require 'growl'

guard 'rspec', {
  cli:            '--colour --format documentation --fail-fast',
  version:        2,
  all_after_pass: false,
  all_on_start:   false,
  notify:         true } do

  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^lib/(.+)\.rb$})     { |m| "spec/lib/#{m[1]}_spec.rb" }
  watch('spec/spec_helper.rb')  { "spec" }
  watch(%r{/lib/facades/helpers/(.+)\.rb$})  { |m| "spec/unit/helpers/#{m[1]}_spec.rb" }
  watch(%r{/lib/facades/patterns/(.+)\.rb$})  { |m| "spec/unit/patterns/#{m[1]}_spec.rb" }
end

guard 'coffeescript', :input => 'src/javascript', :output => 'app/assets/javascripts/', :all_on_start => true