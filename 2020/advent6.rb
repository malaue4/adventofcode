input = File.read('advent6input')
input ||= <<sample
abc

a
b
c

ab
ac

a
a
a
a

b
sample

groups = input.split("\n\n").map { |group| group.split("\n").map(&:chars).reduce(&:&).size }

puts groups.join(' + '), groups.sum