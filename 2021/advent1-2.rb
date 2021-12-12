readings = File.read('advent1input').lines
increased_readings = readings.map(&:to_i).each_cons(3).map(&:sum).each_cons(2).select do |r1, r2|
  r1 < r2
end.size

puts increased_readings