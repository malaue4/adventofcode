vent_lines_input = File.read('advent5input').split("\n")
# vent_lines_input = <<V.split("\n")
# 0,9 -> 5,9
# 8,0 -> 0,8
# 9,4 -> 3,4
# 2,2 -> 2,1
# 7,0 -> 7,4
# 6,4 -> 2,0
# 0,9 -> 2,9
# 3,4 -> 1,4
# 0,0 -> 8,8
# 5,5 -> 8,2
# V
class VentLine
  attr_reader :x1, :y1, :x2, :y2

  def initialize(x1, y1, x2, y2)
    @x1 = x1
    @y1 = y1
    @x2 = x2
    @y2 = y2
  end

  def horizontal?
    y1 == y2
  end

  def vertical?
    x1 == x2
  end

  def to_a
    if horizontal?
      ([x1, x2].min..[x1, x2].max).map { [_1, y1] }
    elsif vertical?
      ([y1, y2].min..[y1, y2].max).map { [x1, _1] }
    else
      x = (x1 < x2) ? x1.upto(x2) : x1.downto(x2)
      y = (y1 < y2) ? y1.upto(y2) : y1.downto(y2)
      x.zip(y)
    end
  end
end
vent_lines = vent_lines_input.map do |vent_line_input|
  /^(?<x1>\d+),(?<y1>\d+) -> (?<x2>\d+),(?<y2>\d+)$/ =~ vent_line_input

  VentLine.new x1.to_i, y1.to_i, x2.to_i, y2.to_i
end
# width = vent_lines.flat_map { [_1.x1, _1.x2] }.max
# height = vent_lines.flat_map { [_1.y1, _1.y2] }.max
grid = Hash.new(0)
vent_lines.each do |vent_line|
  #next unless vent_line.horizontal? or vent_line.vertical?
  vent_line.to_a.each do |point|
    grid[point] += 1
  end
end
# (0..height).each do |y|
#   puts (0..width).map { grid[[_1, y]] }.join.gsub('0', '.')
# end
puts grid.values.select { _1 > 1 }.size
