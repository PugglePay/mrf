begin
  require 'bundler/setup'
rescue LoadError
  puts 'You must `gem install bundler` and `bundle install` to run rake tasks'
end

require 'rdoc/task'

RDoc::Task.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'MrF'
  rdoc.options << '--line-numbers'
  rdoc.rdoc_files.include('README.rdoc')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

Bundler::GemHelper.install_tasks

require 'rake/testtask'

require 'rspec/core'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new do |t|
  # t.warning = true  # We would like to run with warning true, but capybara gives to many warnings.
end

desc "Run all specs in spec directory (excluding plugin specs)"
task :default => :spec
