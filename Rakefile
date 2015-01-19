require 'rake/testtask'
require 'cucumber'
require 'cucumber/rake/task'

Rake::TestTask.new do |t|
	t.libs << 'test'
	t.test_files = FileList['test/test_*.rb']
end

Cucumber::Rake::Task.new(:features) do |t|
	t.cucumber_opts = "features --format pretty -x"
	t.fork = false
end

desc "Run tests"
task :default => :test

# vim: nospell
