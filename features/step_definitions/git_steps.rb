require 'fileutils'

Given /^an empty Git repository$/ do
	in_current_dir do
		`git init`
	end
end

When /^(\d+) commits with identical changelog lines are added$/  do |n|
	in_current_dir do
		n.to_i.times do
			open 'dummy_file_for_commits.txt', 'a' do |f|
				f.puts 'some text'
			end
			`git add -A`
			`git commit -m 'heading' -m '- NEW: Dummy changelog entry'`
		end
	end
end

