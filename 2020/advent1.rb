input = File.read('advent1input').lines(chomp: true)
input ||= <<sample.lines(chomp: true)
1721
979
366
299
675
1456
sample

expenses = input.map(&:to_i)
puts expenses.combination(3).find { |combi| combi.sum == 2020 }.reduce(:*)
