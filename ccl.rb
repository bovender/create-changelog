#!/usr/bin/env ruby
# Create-changelog
# Copyright [yyyy] [name of copyright owner]
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Filters the git log of the repository in the current directory
# for unique lines that match the pattern
#   * [KEYWORD]: [DESCRIPTION]
# The filtered lines are sorted and written to standard out.

require 'optparse'

# Returns the grep string that matches changelog entries.
def pattern
	'\s*\*\s+[^:]+:\s'
end

def is_git_repository(dir = nil)
	dir = Dir.pwd if dir.nil?
	system("git status > /dev/null 2>&1")
	$? == 0
end

# Removes common indentation from an array of strings
class Array
	def remove_indent
		lines_with_indent = self.select do |line|
			line.size > 0
		end
		indents = lines_with_indent.map do |line|
			match = line.match(/^( +)[^ ]+/)
			match ? match[1].size : 0
		end
		indent = indents.min
		self.map do |line|
			line[indent..-1]
		end
	end
end

# Returns the name for the recent changes; this may be
# a version number if one is given on the command line.
def get_recent_changes_heading
	if ARGV.empty?
		"Current version"
	else
		ARGV[0]
	end
end

# Returns an array of lines describing changes between two 
# git commits.
def get_changes(from, to)
	log = `git log #{from}..#{to} -E --grep='#{pattern}' --format=%b`
	log.split("\n").select do |line|
			line.match(pattern)
	end.uniq.sort.remove_indent
end

# Gets change information for a specific tagged version.
# This will prepend the summary for the annotated tag before
# the list of changes. If the tag annotation contains changelog
# entries, they are merged with the changelog entries filtered
# from the commit messages, and only unique entries are used.
def get_version_info(previous_version, desired_version)
	tag = `git tag -l -n99 #{desired_version}`.rstrip
	tag = get_recent_changes_heading if tag.length == 0
	tag = tag.split("\n")

	tag_changelog = tag.select do |line|
		line.match(pattern)
	end.sort.remove_indent

	tag = tag.reject do |line|
		line.match(pattern)
	end
	
	tag = tag.remove_indent.insert(1, "=" * 72 + "\n")

	changelog = get_changes(previous_version, desired_version)
	changelog = changelog.concat(tag_changelog).uniq
	changelog << "\n" + ("* " * 36) +"\n\n"

	tag.concat(changelog).join("\n")
end

# Returns the sha1 of the initial commit.
# In fact, this function returns all parentless commits
# of the repository. Usually there should be not more than
# one such commit.
# See http://stackoverflow.com/a/1007545/270712
def get_initial_commit
	`git rev-list --max-parents=0 HEAD`.chomp
end

# Returns an array of tag names surrounded by HEAD
# at the top and the sha1 of the first commit at the
# bottom.
def get_tags
	tags = []
	tags <<  get_initial_commit
	tags += `git tag`.split("\n").map { |s| s.rstrip }
	tags << "HEAD"
	tags.reverse
end

# Returns the most recent tag in the git repository,
# or the sha1 of the initial commit if there is no tag.
def get_recent_tag
	tags = get_tags
	if tags.length > 2
		get_tags[1]
	else
		get_tags[0]
	end
end

def main
	options = {}
	options[:working_dir] = Dir.pwd
	option_parser = OptionParser.new do |opts|
		executable_name = File.basename($PROGRAM_NAME)
		opts.banner = "Create changelog from log entries in git log\n"
		opts.banner += "Usage: #{executable_name} [options] [current_version]"
		opts.on("-r", "--recent",
						"Include only most recent changes") do 
			options[:recent] = true
		end
		opts.on("-d WORKING_DIR", "--dir WORKING_DIR",
					 "Use alternate working directory") do |dir|
			options[:working_dir] = dir
		end
	end
	option_parser.parse!

	Dir.chdir(options[:working_dir]) do
		abort "FATAL: Not a git repository." unless is_git_repository
		if options[:recent]
			puts get_changes(get_recent_tag, "HEAD")
		else
			get_tags.each_cons(2) do |current_tag, previous_tag|
				puts get_version_info(previous_tag, current_tag)
			end
		end
	end
end

main

# vim: nospell
