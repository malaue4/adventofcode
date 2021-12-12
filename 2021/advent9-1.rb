heightmap_input = File.read('advent9input')
# heightmap_input = <<Smoke
# 2199943210
# 3987894921
# 9856789892
# 8767896789
# 9899965678
# Smoke

heightmap = Hash.new(10)
heightmap_input.split("\n").each_with_index do |line, y|
  line.chars.each_with_index do |char, x|
    heightmap[[x,y]] = char.to_i
  end
end

def find_lowpoints(heightmap)
  heightmap.select do |(x, y), height|
    heightmap[[x-1, y]] > height &&
      heightmap[[x+1, y]] > height &&
      heightmap[[x, y+1]] > height &&
      heightmap[[x, y-1]] > height
  end
end

puts find_lowpoints(heightmap).inspect
puts find_lowpoints(heightmap).values.map(&:next).sum