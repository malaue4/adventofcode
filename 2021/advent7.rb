crabs = File.read('advent7input').split(",").map(&:to_i)
#crabs = [16,1,2,0,4,2,7,1,2,14]
puts crabs.sum/crabs.size

puts Range.new(*crabs.minmax).to_h { |pos| [pos, crabs.map { |crab| (pos - crab).abs }.sum] }.min_by(&:last)

def cost(pos, crab)
  cd = (pos - crab).abs
  (cd*(1+cd))/2
end
puts Range.new(*crabs.minmax).to_h { |pos| [pos, crabs.map { |crab| cost(pos, crab) }.sum] }.min_by(&:last)
