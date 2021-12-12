input = File.read('advent3input').lines(chomp: true)
input ||= <<sample.lines(chomp: true)
..##.......
#...#...#..
.#....#..#.
..#.#...#.#
.#...##..#.
..#.##.....
.#.#.#....#
.#........#
#.##...#...
#...##....#
.#..#...#.#
sample

def f(t, dy, dx=1, rows)
  x=(t*dx) % rows[0].size
  y=(t*dy)
  rows[y][x]
rescue
  puts [t, dy, dx, "ouch"].inspect
end

#safest_path = (1..input[0].size).map do |angle|
#  input.size.times.map { |row_index| f(row_index, angle, input) }
#end.min_by { |path| path.count('#') }

part_2_paths = [[1, 1], [1, 3], [1, 5], [1, 7], [2, 1]].map do |dy, dx|
  path = (0..input.size/dy).map { |row_index| f(row_index, dy, dx, input) }
  puts "#{dy}d#{dx}r path:", path.inspect, path.count('#')
  path
end

puts part_2_paths.map { _1.size }
puts part_2_paths.map { _1.count('#') }.reduce(:*)

#puts "Safest path:", safest_path.inspect, safest_path.count('#')
