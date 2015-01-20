# git.rb, part of Create-changelog
# Copyright 2015 Daniel Kraus
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
require_relative 'tag_list'

# A static wrapper class for git
class Git

	# Determines whether the (current) directory is a git repository
	def self.is_git_repository?(dir = nil)
		dir = Dir.pwd if dir.nil?
		system("git status > /dev/null 2>&1")
		$? == 0
	end

	# Determines if the repository in the current directory is empty.
	def self.is_empty_repository?
		`git show HEAD > /dev/null 2>&1`
		$? != 0
	end

	# Retrieves the first 99 lines of the annotation of a tag.
	def self.get_tag_annotation(tag)
		test_tag tag
		`git tag -l -n99 #{tag}`.rstrip
	end

	# Retrieves the date of a tag
	def self.get_tag_date(tag)
		test_tag tag
		`git log -1 --format=format:%ai #{tag}`
	end

	# Retrieves commit messages and filters them
	# Todo: Armor this against code injection!
	def self.get_filtered_messages(from_commit, to_commit, filter)
		`git log #{from_commit}..#{to_commit} -E --grep='#{filter}' --format=%b`
	end

	# Retrieves one commit message and filters it
	# Todo: Armor this against code injection!
	def self.get_filtered_message(commit, filter)
		`git log #{commit} -E --grep='#{filter}' --format=%b`
	end

	@@tags = nil

	# Ensures lazy loading of the tag list to enable calling code
	# to change the working directory first.
	def self.tags
		@@tags = TagList.new unless @@tags
		@@tags
	end

	# Tests if the given tag exists and fails if it doesn't
	def self.test_tag(tag)
		fail "Invalid tag: #{tag}" unless tags.list.include?(tag)
	end
	private_class_method :test_tag, :tags
end

# vim: nospell
