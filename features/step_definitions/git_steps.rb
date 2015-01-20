require 'fileutils'
require 'securerandom'

Given /^an empty Git repository$/ do
	in_current_dir do
		`git init`
	end
end

When /^(\d+) commits with identical changelog lines are added$/  do |n|
	in_current_dir do
		n.to_i.times do
			alter_dummy_file
			`git add -A`
			`git commit -m 'heading' -m '- NEW: Dummy changelog entry'`
		end
	end
end

When /^(\d+) commits with unique changelog lines are added$/  do |n|
	in_current_dir do
		n.to_i.times do
			alter_dummy_file
			`git add -A`
			`git commit -m 'heading' -m '- NEW: #{random_string}'`
		end
	end
end

def alter_dummy_file
	open 'dummy_file_for_commits.txt', 'a' do |f|
		f.puts 'some text'
	end
end

def random_string
	# ('a'..'z').to_a.shuffle[0,8].join
	SecureRandom.hex
end
