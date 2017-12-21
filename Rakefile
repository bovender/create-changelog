require 'rake/testtask'
require 'cucumber'
require 'cucumber/rake/task'
require 'yard'

# YARD::Rake::YardocTask.new

Rake::TestTask.new do |t|
	t.libs << 'test'
	t.test_files = FileList['test/test_*.rb']
end

Cucumber::Rake::Task.new(:features) do |t|
	t.cucumber_opts = "features --format pretty --no-source"
	t.fork = false
end

desc "Run tests"
task :default => :test

# vim: nospell
