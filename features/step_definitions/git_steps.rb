require 'fileutils'
require 'securerandom'

Given /^an empty Git repository$/ do
	in_current_dir do
		`git init`
	end
end

When(/^(\d+) commits with standard changelog line are added$/) do |n|
	in_current_dir do
		n.to_i.times do
			alter_dummy_file
			`git add -A`
			`git commit -m 'heading' -m '#{standard_log_entry}'`
		end
	end
end

When(/^(\d+) commits with unique changelog line are added$/) do |n|
	in_current_dir do
		n.to_i.times do
			alter_dummy_file
			`git add -A`
			`git commit -m 'heading' -m '#{random_log_entry}'`
		end
	end
end

When(/a tag without changelog line is added/) do
	in_current_dir do
		`git tag -a some-tag -m "Some tag"`
	end
end	

When(/a tag with unique changelog line is added/) do
	in_current_dir do
		`git tag -a some-tag -m "Some tag" -m '#{random_log_entry}'`
	end
end

When(/a tag with standard changelog line is added/) do
	in_current_dir do
		`git tag -a some-tag -m "Some tag" -m '#{standard_log_entry}'`
	end
end

def alter_dummy_file
	open 'dummy_file_for_commits.txt', 'a' do |f|
		f.puts 'some text'
	end
end

def standard_log_entry
	"- INFO: This is a standard log entry for testing"
end

def random_log_entry
	# ('a'..'z').to_a.shuffle[0,8].join
	"- INFO: This is a unique log entry for testing - #{SecureRandom.hex}"
end
