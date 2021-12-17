input = File.read('advent15input')

sample = <<sample
1163751742
1381373672
2136511328
3694931569
7463417111
1319128137
1359912421
3125421639
1293138521
2311944581
sample

fifth = (0...5).map do |piece|
  piece.times.reduce(input) { |string| string.tr('1-9', '2-91') }.lines(chomp: true)
end.transpose.map { _1.join }.join("\n")

whole = (0...5).map do |piece|
  piece.times.reduce(fifth) { |string| string.tr('1-9', '2-91') }
end.join("\n").lines(chomp: true)

grid = {}
whole.each_with_index do |line, y|
  line.each_char.with_index do |char, x|
    grid[[x, y]] = char.to_i
  end
end

start = [0, 0]
stop = grid.keys.transpose.map(&:max)
puts stop.inspect
frontier = { start => 0 }
visited = {}

def get_adjacent(pos, grid)
  x, y = pos
  [
    [x - 1, y], [x, y - 1], [x + 1, y], [x, y + 1]
  ].to_h { |other_pos| [other_pos, grid[other_pos]] }.compact
end

while frontier.any?
  pos, cost_to_here = frontier.shift
  visited[pos] = cost_to_here

  adjacent = get_adjacent(pos, grid)
  adjacent.each do |other_pos, risk_level|
    if frontier.key? other_pos
      frontier[other_pos] = cost_to_here + risk_level if cost_to_here + risk_level < frontier[other_pos]
    elsif visited.key?(other_pos)
      frontier[other_pos] = cost_to_here + risk_level if cost_to_here + risk_level < visited[other_pos]
    else
      frontier[other_pos] = cost_to_here + risk_level
    end
  end
end

width, height = stop
puts((0..height).map { |y|
  (0..width).map { |x|
    visited[[x, y]].to_s + "\t"
  }.join
}.join("\n"))

shortest_path = begin
  path = [stop]
  until path.first == start
    step = path.first
    path.unshift get_adjacent(step, visited).min_by(&:last).first
  end
  path
end

puts path.inspect
puts((0..height).map { |y|
  (0..width).map { |x|
    path.include?([x, y]) ? '*' : '.'
  }.join
}.join("\n"))

puts visited[stop]