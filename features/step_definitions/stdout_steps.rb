Then(/^the stdout should contain 1 line starting with "([^"]*)"$/) do |s|
	assert_lines_starting_with all_stdout, 1, s
end

Then(/^the stdout should contain (\d+) lines starting with "([^"]*)"$/) do |n, s|
	assert_lines_starting_with all_stdout, n, s
end
