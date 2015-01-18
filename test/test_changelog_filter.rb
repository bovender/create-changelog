require 'test/unit'
require_relative '../lib/changelog_filter'

class TestChangelogFilter < Test::Unit::TestCase
	def test_filter_from_string
		log_entry = "- TEST: This is a test log entry"
		string = <<-EOF
			This is a multiline
			test string
			#{log_entry}
			and more text
			EOF
		filter = ChangelogFilter.FromString(string)
		assert(filter.changelog.length == 1,
			'Filter should contain one changelog entry.')
		assert(filter.changelog[0].lstrip == log_entry,
			'Filtered changelog did not contain test entry.')
		assert(filter.other_text.size == 3,
			'Other text should have 3 lines')
	end
end
