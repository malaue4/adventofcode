input = File.read('advent10input').lines(chomp: true)
sample = <<joltages.lines(chomp: true)
16
10
15
5
1
11
7
19
6
12
4
joltages

def get_compatible(joltage, adapters)
  { joltage => adapters.select do |it|
    (1..3).cover?(it - joltage)
  end.map do
    get_compatible(_1, adapters)
  end.reduce(&:merge) }
end

def chanify_tree(tree, head=[])
  tree.each_with_object({}) do |(key, value), chains|
    if value.is_a? Hash
      chains.merge! chanify_tree(value, head+[key])
    else
      chains[head+[key]] = value
    end
  end
end

adapters = sample.map(&:to_i)
tree = get_compatible(0, [*adapters, adapters.max+3])
chains = chanify_tree tree
puts chains.size
=begin #all adapters
  differences = [0, *adapters, adapters.max+3].sort.each_cons(2).each_with_object([]) do |(adp1, adp2), differences|
    differences << adp2 - adp1
  end

  puts differences.inspect, differences.tally.values.reduce(:*)
=end