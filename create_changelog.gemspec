require 'date'
require_relative 'lib/version'

Gem::Specification.new do |s|
	s.name         = 'create_changelog'
	s.version      = CreateChangelog::VERSION
	s.date         = Date.today
	s.summary      = "Creates end-user-friendly changelog from git messages."
	s.description  = <<-EOF
		Ruby program with command-line interface that creates a changelog from log
		lines in a git repository that can be read and understood by end users.
		EOF
	s.authors      = ["Daniel Kraus"]
	s.email        = 'krada@gmx.net'
	s.files        = Dir.glob("{bin,lib}/**/*") + %w(README.md CHANGELOG.md)
	s.executables << 'ccl'
	s.homepage     = "https://github.com/bovender/create-changelog"
	s.license      = "Apache License version 2"
	s.platform     = Gem::Platform::RUBY
	s.post_install_message = <<EOF
#{s.name} version #{s.version} has been installed.
For usage information, type #{s.executables[0]} -h
EOF
	s.add_development_dependency('aruba')
end

# vim: nospell
