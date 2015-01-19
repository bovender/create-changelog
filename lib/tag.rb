# tag.rb, part of Create-changelog
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
require 'date'
require_relative 'git'
require_relative 'changelog_filter'

# Represents a git tag and its annotation.
class Tag
	# The heading of the tag annotation.
	attr_accessor :heading
	
	# Array of lines in the tag annotation that are not changelog entries.
	attr_reader :text

	# Array of lines in the tag annotation that are changelog entries.
	attr_reader :changelog

	# Author commit date of the tag
	attr_reader :date

	# Gets change information for a specific tagged version.
	# This will prepend the summary for the annotated tag before
	# the list of changes. If the tag annotation contains changelog
	# entries, they are merged with the changelog entries filtered
	# from the commit messages, and only unique entries are used.
	def initialize(tag)
		annotation = Git.get_tag_annotation(tag)
		@date = Date.parse(Git.get_tag_date(tag))
		if annotation
			annotation = annotation.split("\n")
			@heading = annotation.shift
			@heading = @heading.split(' ')[1..-1].join(' ') if @heading
			filter = ChangelogFilter.FromArray(annotation)
			@text = filter.other_text.remove_indent if filter.other_text
			@changelog = filter.changelog
		end
	end
end

# vim: nospell
