require 'test/unit'
require_relative '../lib/tag_list'

class TestTagList < Test::Unit::TestCase
	def test_list_is_enclosed
		tags = TagList.new
		assert(tags.list[0] == 'HEAD',
			'First element in list should be HEAD')
		assert(tags.list[-1].length == 40,
			'Last element in list should be SHA-1 hash')
	end
end
