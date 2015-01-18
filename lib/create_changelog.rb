# changelog.rb, part of Create-changelog
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
require_relative './commit_changelog.rb'
require_relative './tag_list.rb'
require_relative './tag.rb'

# Central class that puts together the changelog.
class Changelog
	# Heading for the most recent changes.
	attr_writer :recent_changes_heading

	def initialize
		@recent_changes_heading = "Unpublished changes"
	end

	# Generates a decorated changelog.
	def generate(exclude_recent = false)
		# Traverse tags
		tags = TagList.new(!exclude_recent)
		output = String.new
		tags.list.each_cons(2) do |current_tag, previous_tag|
			output << generate_for(current_tag, previous_tag)
		end
		output
	end

	# Returns a simple, undecorated list of changelog entries
	# since the most recent tag.
	def generate_recent
		tags = TagList.new
		log = CommitChangelog.new(tags.list[0], tags.list[1])
		log.changelog
	end

	private

	def generate_for(current_tag, previous_tag)
		tag = Tag.new(current_tag)
		commit_changelog = CommitChangelog.new(current_tag, previous_tag)

		# Combine changelog entries from tag annotation and commit messages
		if tag.changelog
			combined_changelog = tag.changelog.concat(commit_changelog.changelog)
		else
			combined_changelog = commit_changelog.changelog
		end
		combined_changelog.uniq! if combined_changelog

		output = String.new
		tag.heading = @recent_changes_heading unless tag.heading
		if tag.heading
			output << tag.heading + " (#{tag.date})\n"
			output << "=" * 72 + "\n"
		end
		output << tag.text.join("\n") + "\n" if tag.text
		output << combined_changelog.join("\n") + "\n" if combined_changelog
		output << end_separator if tag.heading or tag.text or combined_changelog
		output
	end

	def end_separator
		"\n" + ("* " * 36) +"\n\n\n"
	end
end

# vim: nospell
