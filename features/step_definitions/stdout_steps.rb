Then(/^the stdout should contain 1 line starting with "([^"]*)"$/) do |s|
	expected = "(^#{s}.*\n){1}"
	assert_matching_output(expected, all_output)
end

Then(/^the stdout should contain (\d+) lines starting with "([^"]*)"$/) do |n, s|
	expected = "(^#{s}.*\n){#{n}}"
	assert_matching_output(expected, all_output)
end
