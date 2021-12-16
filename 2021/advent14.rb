input = File.read('advent14input').lines(chomp: true)

sample = <<sample.lines(chomp: true)
NNCB

CH -> B
HH -> N
CB -> H
NH -> C
HB -> C
HC -> B
HN -> C
NN -> C
BH -> H
NC -> B
NB -> B
BN -> B
BB -> N
BC -> B
CC -> N
CN -> C
sample

template, _, *insertion_rules = input

insertion_rules = insertion_rules.to_h do |rule|
  key, result = rule.split(' -> ')
  [key, [key[0]+result, result+key[1]]]
end

puts insertion_rules

pairs = Hash.new(0)
template.each_char.each_cons(2) { |pair| pairs[pair.join] += 1 }
40.times do
  new_pairs = Hash.new(0)
  #puts pairs
  pairs.each do |pair, count|
    insertions = insertion_rules[pair]
    if insertions.any?
      new_pairs[insertions[0]] += count
      new_pairs[insertions[1]] += count
    else
      new_pairs[pair] += count
    end
  end
  pairs = new_pairs
end

singles = pairs.map do |key, count|
  [key.chars.first, count] #.map { |char| [char, count] }
end.each_with_object(Hash.new(0)) do |(char, count), tally|
  tally[char] += count
end

singles[template.chars.last] += 1
puts singles.values.minmax.reduce(&:-)