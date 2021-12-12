require 'set'
inputs = File.read('advent11input').lines(chomp: true)
sample ||= <<lines.lines(chomp: true)
5483143223
2745854711
5264556173
6141336146
6357385478
4167524645
2176841721
6882881134
4846848554
5283751526
lines

class Squid < Struct.new(:x, :y, :energy, :flashed)
  def neighbours
    @neighbours ||= Set.new
  end

  def neighbours=(neighbourhood)
    neighbours.clear
    neighbourhood.each do |neighbour|
      neighbours.add neighbour
    end
  end

  def add_neighbour(squid)
    neighbours.add squid
    squid.neighbours.add self
  end

  def flash!
    self.flashed = true
    neighbours.each(&:powerup!)
  end

  def powerup!
    self.energy += 1
  end

  def can_flash?
    !flashed and energy > 9
  end

  def flashed?
    flashed
  end

  def reset!
    self.energy = 0
    self.flashed = false
  end
end

squid_grid = {}
inputs.each_with_index do |line, y|
  line.each_char.with_index do |char, x|
    squid_new = Squid.new x, y, char.to_i
    squid_grid[[x,y]] = squid_new
    [
      squid_grid[[x-1,y]],
      squid_grid[[x-1,y-1]],
      squid_grid[[x,y-1]],
      squid_grid[[x+1,y-1]],
    ].compact.each { |neighbour| squid_new.add_neighbour neighbour }
  end
end

drawing = (0...100).map do |i|
  x = i % 10
  y = i / 10
  "#{squid_grid[[x, y]].neighbours.size}#{"\n" if x == 9}"
end.join
puts drawing

flash_count = 0
step = 1
loop do
  #puts "Step: #{step}"
  #drawing = (0...100).map do |i|
  #  x = i % 10
  #  y = i / 10
  #  "#{squid_grid[[x, y]].energy}#{"\n" if x == 9}"
  #end.join.gsub(/[^0\n]/, '.')
  #puts drawing
  #puts
  #bump energy
  squid_grid.values.each(&:powerup!)
  #flash squids
  loop do
    flashers = squid_grid.values.select(&:can_flash?)
    flashers.each(&:flash!)
    break if flashers.empty?
  end
  if squid_grid.values.all?(&:flashed?)
    puts step
    break
  end
  step += 1
  flash_count += squid_grid.values.select(&:flashed?).each(&:reset!).size
end

puts flash_count