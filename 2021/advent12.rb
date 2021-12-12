input = File.read("advent12input").lines(chomp: true)
small_sample ||= <<lines.lines(chomp: true)
start-A
start-b
A-c
A-b
b-d
A-end
b-end
lines
larger_sample ||= <<lines.lines(chomp: true)
fs-end
he-DX
fs-he
start-DX
pj-DX
end-zg
zg-sl
zg-pj
pj-he
RW-he
fs-DX
pj-RW
zg-RW
start-pj
he-WI
zg-he
pj-fs
start-RW
lines

def big(cave)
  cave == cave.upcase
end

def small(cave)
  cave == cave.downcase
end

def generate_nodes(input)
  input.map { |connection| connection.split('-') }.each_with_object(Hash.new([])) do |(cave1, cave2), nodes|
    nodes[cave1] |= [cave2] unless (cave2 == 'start') || (cave1 == 'end')
    nodes[cave2] |= [cave1] unless (cave1 == 'start') || (cave2 == 'end')
  end
end

def find_paths(nodes, path = ['start'], small_used = false)
  from = path.last

  return path.join(',') if from == 'end'

  options = nodes[from]
  options.flat_map do |option|
    needs_small = small(option) && path.include?(option)
    # puts "#{option} is small == #{small(option)} and #{path} includes #{option} == #{path.include?(option)} == #{needs_small}"
    next if needs_small && small_used

    find_paths(nodes, path + [option], small_used || needs_small)
  end.compact
end

nodes = generate_nodes(small_sample)
paths = find_paths(nodes)
puts paths.size

nodes = generate_nodes(larger_sample)
paths = find_paths(nodes)
puts paths.size

nodes = generate_nodes(input)
paths = find_paths(nodes)
puts paths.size
