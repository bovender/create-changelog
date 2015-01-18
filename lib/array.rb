# Removes common indentation from an array of strings
class Array
	def remove_indent
		lines_with_indent = self.select do |line|
			line.size > 0
		end
		indents = lines_with_indent.map do |line|
			match = line.match(/^( +)([^ ]|$)+/)
			match ? match[1].size : 0
		end
		indent = indents.min
		self.map do |line|
			line[indent..-1]
		end
	end
end

# vim: nospell
