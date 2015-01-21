# Checks whether a mult-line text contains a specific number
# of lines that start with a given sequence.
def assert_lines_starting_with(text, number, start_with)
	number = number.to_i if number.is_a? String
	count = text.split("\n").count { |line| line.start_with? start_with }
	expect(count).to eq number
end
