readings = File.read('advent1input').lines
increased_readings = readings.each_cons(2).select do |r1, r2|
  r1.to_i < r2.to_i
end.count

puts increased_readings