diagnostics = File.read('advent3input').split("\n")
tally = diagnostics.map(&:chars).transpose.map do |column|
  column.group_by(&:itself).transform_values(&:size)
end
gamma_rate = tally.map do |o|
  o["0"] > o["1"] ? '0' : '1'
end.join.to_i(2)
epsilon_rate = tally.map do |o|
  o["0"] < o["1"] ? '0' : '1'
end.join.to_i(2)
puts gamma_rate, epsilon_rate, gamma_rate*epsilon_rate