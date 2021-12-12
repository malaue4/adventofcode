input = File.read('advent2input').lines(chomp: true)
input ||= <<sample.lines(chomp: true)
1-3 a: abcde
1-3 b: cdefg
2-9 c: ccccccccc
sample

# PART 1
valid_passwords = input.select do |line|
  /(?<min>\d+)-(?<max>\d+) (?<required_character>[a-z]): (?<password>[a-z]+)/ =~ line
  (min.to_i..max.to_i).cover? password.count(required_character)
end

puts "#{valid_passwords.size} / #{input.size}"

# PART 2
valid_passwords = input.select do |line|
  /(?<first>\d+)-(?<second>\d+) (?<required_character>[a-z]): (?<password>[a-z]+)/ =~ line
  pos1 = password[first.to_i-1]
  pos2 = password[second.to_i-1]
  (pos1 == required_character or pos2 == required_character) and pos1 != pos2
end

puts "#{valid_passwords.size} / #{input.size}"