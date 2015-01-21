# commit_changelog.rb, part of Create-changelog
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
require_relative 'changelog_filter'

# Filters commit messages for changelog entries.
class CommitChangelog
	# Contains changelog entries of the commits.
	attr_reader :changelog

	# Instantiates an object containing changelog entries between
	# two git commits.
	def initialize(to_commit, from_commit)
		pattern = ChangelogFilter.pattern
		messages = Git.get_filtered_messages(from_commit, to_commit, pattern)
		filter = ChangelogFilter.FromString(messages)
		@changelog = filter.changelog
	end

	# Adds changelog information contained in a specific commit message.
	def add_commit(commit)
		pattern = ChangelogFilter.pattern
		filtered_text = Git.get_filtered_message(commit, pattern)
		if filtered_text
			filtered_lines = filtered_text.split("\n").uniq
			if @changelog
				@changelog = @changelog.concat(filtered_lines).uniq
			else
				@changelog = filtered_lines
			end
		end
	end
end

# vim: nospell
