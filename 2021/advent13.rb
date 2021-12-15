input = File.read("advent13input")
small_sample ||= <<lines
6,10
0,14
9,10
0,3
10,4
4,11
6,0
6,12
4,1
0,13
10,12
3,4
3,0
8,4
1,10
2,14
8,10
9,0

fold along y=7
fold along x=5
lines

coords, folds = input.split("\n\n").map { |input| input.lines(chomp: true) }

puts coords.inspect, folds.inspect
coords = coords.map do |coord|
  coord.split(',').map(&:to_i)
end
folds = folds.map do |fold|
  /(?<dir>[xy])=(?<pos>\d+)/ =~ fold
  [dir, pos.to_i]
end
puts coords.inspect, folds.inspect


def func(coords)
  width, height = coords.transpose.map { |it| it.max + 1 }

  puts width, height
  (0...(width*height)).flat_map do |i|
    x, y = i % width, i / width
    [
      coords.include?([x, y]) ? '#' : '.',
      ("\n" if x == width-1)
    ].compact
  end.join
end


#g = func(coords)
#puts g
folds.each do |dir, pos|
  case dir
  when 'x'
    coords = coords.map do |x, y|
      new_x = x > pos ? pos - (x - pos) : x
      [new_x, y]
    end
  when 'y'
    coords = coords.map do |x, y|
      new_y = y > pos ? pos - (y - pos) : y
      [x, new_y]
    end
  end
end
#g = func(coords)
#puts g

puts coords.uniq.count
g = func(coords.uniq)
puts g