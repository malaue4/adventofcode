commands = File.read('advent2input').lines.map(&:split)
hpos = 0
depth = 0
commands.each do |direction, amount|
  case direction
  when 'forward'
    hpos += amount.to_i
  when 'up'
    depth -= amount.to_i
  when 'down'
    depth += amount.to_i
  else
    puts "What does #{command} mean?"
  end
end

puts hpos, depth, hpos*depth