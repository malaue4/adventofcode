input = File.read('advent5input').lines(chomp: true)

input ||= <<sample.lines(chomp: true)
BFFFBBFRRR
FFFBBBFRRR
BBFFBBFRLL
sample

def bsp(items, inputs)
  inputs.reduce(0...items) do |r, input|
    half_size = r.size / 2
    case input
    when 'F', 'L'
      r.min...(r.min+half_size)
    when 'B', 'R'
      (r.min+half_size)..r.max
    end
  end.min
end

seat_ids = input.map do |seating|
  row = bsp(128, seating.chars[0...7])
  column = bsp(8, seating.chars[7...10])
  puts [row, column, row*8+column].inspect
  row*8+column
end

puts Range.new(*seat_ids.minmax).to_a - seat_ids