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

def find_basins(heightmap, lowpoints)
  basins = []
  lowpoints.each do |lowpoint|
    next if basins.any? { |lp| lp.include? lowpoint }
    basin = []
    candidates = [lowpoint]
    until candidates.empty?
      candidate = candidates.shift
      basin << candidate
      (x, y), h = candidate

      [[x-1, y],[x+1, y],[x, y-1],[x, y+1]].each do |adjacent_point|
        height = heightmap[adjacent_point]
        if height < 9 and not (basin + candidates).include?([adjacent_point, height])
          candidates << [adjacent_point, height]
        end
      end
    end
    basins << basin
  end
  basins
end

lowpoints = find_lowpoints(heightmap)
#puts lowpoints.inspect
#puts lowpoints.values.map(&:next).sum

basins = find_basins(heightmap, lowpoints)
pp basins.map(&:size).sort.last(3).reduce(&:*)
