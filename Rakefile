require_relative 'config/application'

Rails.application.load_tasks

begin
  require 'rspec/core/rake_task'

  RSpec::Core::RakeTask.new(:spec)

  task :default => :spec
rescue LoadError => error
  raise unless error.message.include?('spring')
end
