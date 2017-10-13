require 'java'

$CLASSPATH << './java_classes'

java_import Java::GraphicsWindow
java_import java.awt.Color
java_import java.awt.Font

require './1d_ca.rb'

print 'Initial Rule : '
rule = gets.chomp.to_i

win_x, win_y = 1200, 700
window = GraphicsWindow.new("1D Cellular Automata", win_x, win_y, 20, 20, true)

cell_size = 2
board = Board.new row: (1..(win_x/cell_size - 1)).map { |i| i == win_x/(cell_size * 2) ? 1 : 0 }
time = 0

loop do
	board.apply_rule(rule)
	window.paint_background(Color.black)
	pen = window.pen
	pen.set_color(Color.white)
	board.rows.each_with_index do |r,j|
		r.each_with_index do |e,i|
			next if e.zero?
			pen.fill_rect(cell_size*i, cell_size*j, cell_size, cell_size)
		end
	end

	pen.set_color(Color.black)
	pen.fill_rect(20, 10, 135, 45)
	pen.set_color(Color.white)
	pen.set_font(Font.new("Roboto", Font::PLAIN, 25))
	pen.draw_string("Rule: #{rule}", 30, 40)

	window.flip
	board.trim_rows(1) if board.rows.count >= win_y/cell_size

	sleep 0.02

	time += 1
	if time % (win_y/cell_size) == 0
		time = 0
		rule = rand(0..255)
	end
end


#printing to console
# board = Board.new row: (1..159).map { |i| i == 80 ? 1 : 0 }#width: 160
# loop do 
# 	board.apply_rule(18)
# 	puts board.rows.last.map { |e| e == 1 ? 'X' : ' '}.join
# 	sleep 0.1
# end