class Board
	attr_reader :rows

	def initialize options
		default_width = 20
		width = options[:width] ? options[:width] : default_width
		@rows = options[:row] ? [options[:row]] : [Array.new(width) { rand(0..1) }]
		@parent_types = (0..7).map { |i| ("0" * (3 - i.to_s(2).length) + i.to_s(2)).split('').map { |j| j.to_i } }.reverse
	end

	def apply_rule(num)
		code = ("0" * (8 - num.to_s(2).length) + num.to_s(2)).chars.map { |i| i.to_i }
		@rows << [0] + (0..@rows.last.length-3).map { |i| code[@parent_types.index(@rows.last[i,3])] } + [0]
	end

	def trim_rows(num)
		@rows.shift(num)
	end
end