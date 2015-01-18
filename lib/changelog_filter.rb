# changelog_filter.rb, part of Create-changelog
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

require_relative 'array'

# Filters a text or array for changelog entries.
class ChangelogFilter
	# Factory method that creates an instance given a text string
	def self.FromString(string)
		unless string.is_a?(String)
			fail "Must call this factory with String, not " + string.class.to_s
		end
		self.FromArray(string.chomp.split("\n"))
	end

	# Factory method that creates an instance given an array of strings
	def self.FromArray(ary)
		unless ary.is_a?(Array)
			fail "Must call this factory with Array, not " + ary.class.to_s
		end
		filter = ChangelogFilter.new
		log, filter.other_text = ary.partition do |line|
			line.match(pattern)
		end
		filter.changelog = log.uniq.sort.remove_indent if log.length > 0
		filter
	end

	# Returns the grep string that matches changelog entries.
	def self.pattern
		'\s*[*-]\s+[^:]+:\s'
	end

	# An array of changelog entries.
	attr_accessor :changelog

	# An array of text lines that are not changelog entries.
	attr_accessor :other_text

	private

	def initialize
	end
end

# vim: nospell
