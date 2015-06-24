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

	@@tags = nil

	# Generates a decorated changelog for the entire commit history.
	#
	# @param [bool] exclude_recent
	#   Indicates whether to exclude recent changelog lines that were
	#   added since the last tag.
	#
	#	@return [String]
	#   Decorated changelog, or nil if no lines were found.
	#   
	def generate(exclude_recent = false)
		# Traverse tags
		@@tags = TagList.new(!exclude_recent)
		output = String.new
		@@tags.list.each_cons(2) do |current_tag, previous_tag|
			output << generate_for(current_tag, previous_tag)
		end
		output.length > 0 ? output : nil
	end

	# Generates a simple, undecorated list of changelog entries
	# since the most recent tag.
	#
	# @return [Array]
	#   Array of changelog lines, or nil if no lines were found.
	#   
	def generate_recent
		@@tags = TagList.new
		log = CommitChangelog.new(@@tags.list[0], @@tags.list[1])
		# Explicitly add initial commit if there is no tag yet
		# This is necessary because HEAD..OTHER_COMMIT does not include
		# OTHER_COMMIT's message, which is the desired behavior if
		# OTHER_COMMIT is a tag for a previous version, but undesired
		# if OTHER_COMMIT is the initial commit of the repository.
		log.add_commit @@tags.list[1] if @@tags.list.length == 2
		log.changelog
	end

	private

	# Generates decorated changelog information including the current_tag's
	# annotation and all changelog lines written in commit messages since the
	# previous_tag.  Note that this will exclude previous_tag's annotation,
	# except if previous_tag is not a tag, but the initial commit in the
	# repository. 
	#
	# @param [String] current_tag
	#   Version tag for which to collect changelog information.
	#   
	#	@param [String] previous_tag
	#   Previous version tag whose changelog information does not belong to
	#   the current version's changelog information. However, if previous_tag
	#   is the Sha-1 hash of the initial commit, its changelog lines _will_ be
	#   included.
	#
	#	@return [String]
	#   Changelog decorated with markdown formatting, or empty string.
	#   
	def generate_for(current_tag, previous_tag)
		tag = Tag.new(current_tag)
		commit_changelog = CommitChangelog.new(current_tag, previous_tag)

		# If previous_tag is the initial commit, make sure to include its message
		commit_changelog.add_commit previous_tag if previous_tag == @@tags.list[-1]

		# Combine changelog entries from tag annotation and commit messages
		if tag.changelog
      if commit_changelog.changelog
        combined_changelog = tag.changelog.concat(commit_changelog.changelog)
      else
        combined_changelog = tag.changelog
      end
		else
			combined_changelog = commit_changelog.changelog
		end
		combined_changelog.uniq! if combined_changelog

		output = String.new
		tag.heading = @recent_changes_heading unless tag.heading
		if tag.heading and (tag.text or combined_changelog)
			output << tag.heading + " (#{tag.date})\n"
			output << "=" * 72 + "\n"
		end
		output << tag.text.join("\n") if tag.text
		output << "\n" if tag.heading or tag.text
		output << combined_changelog.join("\n") + "\n" if combined_changelog
		output << end_separator if tag.text or combined_changelog
		output
	end

	# Markdown-compatible horizontal 'ruler'.
	#
	# @return [String]
	#
	def end_separator
		"\n" + ("* " * 36) +"\n\n\n"
	end
end

# vim: nospell
