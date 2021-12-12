input = File.read('advent7input').lines(chomp: true)
input ||= <<sample.lines(chomp: true)
light red bags contain 1 bright white bag, 2 muted yellow bags.
dark orange bags contain 3 bright white bags, 4 muted yellow bags.
bright white bags contain 1 shiny gold bag.
muted yellow bags contain 2 shiny gold bags, 9 faded blue bags.
shiny gold bags contain 1 dark olive bag, 2 vibrant plum bags.
dark olive bags contain 3 faded blue bags, 4 dotted black bags.
vibrant plum bags contain 5 faded blue bags, 6 dotted black bags.
faded blue bags contain no other bags.
dotted black bags contain no other bags.
sample
input ||= <<sample2.lines(chomp: true)
shiny gold bags contain 2 dark red bags.
dark red bags contain 2 dark orange bags.
dark orange bags contain 2 dark yellow bags.
dark yellow bags contain 2 dark green bags.
dark green bags contain 2 dark blue bags.
dark blue bags contain 2 dark violet bags.
dark violet bags contain no other bags.
sample2
rules = input.to_h do |rule|
  lhs, rhs = rule.split(' bags contain ')
  contained = rhs.gsub(/ bags?\.?/, '').split(', ').reject { |bag| bag == 'no other' }.to_h do |bag|
    amount, color = bag.split(' ', 2)
    [color, amount.to_i]
  end
  [lhs, contained]
end

false and begin
  simplified_rules = rules.transform_values(&:keys)
  candidates = ['shiny gold']
  good = []
  until candidates.empty?
    candidate = candidates.pop
    simplified_rules.select do |container, containees|
      if containees.include? candidate
        candidates |= [container]
        good |= [container]
      end
    end
  end

  puts good.size
end

frontier = rules['shiny gold'].flat_map { |color, amount| [color]*amount }
bag_count = 0
until frontier.empty?
  puts frontier.inspect
  bag = frontier.pop
  bag_count += 1
  rules[bag].each do |color, amount|
    frontier += [color]*amount
  end
end

puts bag_count