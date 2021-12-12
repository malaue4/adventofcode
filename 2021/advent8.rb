entries = File.read('advent8input').split("\n")
#entries = ["acedgfb cdfbe gcdfa fbcad dab cefabd cdfgeb eafb cagedb ab | cdfeb fcadb cdfeb cdbaf"]
def print_display(*segments)
  template = <<segment.gsub('_', ' ')
_aaaa_
b    c
b    c
_dddd_
e    f
e    f
_gggg_
segment
  interlaced = segments.map do |segment|
    template.gsub(/[^#{segment}\n ]/, '.').split("\n")
  end.reduce(&:zip)
  puts *interlaced.map { _1.join('  ') }
end


occurrences = Hash.new 0

entries.each do |entry|
  _, output = entry.split('|')
  digits = output.split
  #print_display(*digits)
  digits.each do |digit|
    case digit.size
    when 2
      occurrences[1] += 1
    when 3
      occurrences[7] += 1
    when 4
      occurrences[4] += 1
    when 7
      occurrences[8] += 1
    end
  end
end

puts occurrences, occurrences.values.sum
## PART 2
require 'set'
def determine_digit(digit, wires, wire_map)
  if digit.size == 7
    wires[8] = digit
  elsif digit.size == 6 and wires.key?(1) and wires.key?(4)
    if wires[1].subset? digit
      if wires[4].subset? digit
        wires[9] = digit
        wire_map['e'] = (wires[8] - digit).first
        wire_map['g'] = (digit - wires[4] - [wire_map['a']]).first if wire_map.key?('a')
      else
        wires[0] = digit
        wire_map['d'] = (wires[8] - digit).first
      end
    else
      wires[6] = digit
      wire_map['c'] = (wires[8] - digit).first
    end
  elsif digit.size == 5 and wires.key?(1) and wires.key?(4)
    if wires[1].subset? digit
      wires[3] = digit
    else
      if (digit - wires[4]).size == 2
        wires[5] = digit
      else
        wires[2] = digit
      end
    end
  elsif digit.size == 4
    wires[4] = digit
  elsif digit.size == 4
    wires[4] = digit
  elsif digit.size == 3
    wires[7] = digit
    wire_map['a'] = (digit-wires[1]).first if wires.key?(1)
  elsif digit.size == 2
    wires[1] = digit
    wire_map['a'] = (wires[7]-digit).first if wires.key?(7)
    wire_map['f'] = (digit - [wire_map['c']]).first if wire_map.key?('c')
    wire_map['c'] = (digit - [wire_map['f']]).first if wire_map.key?('f')
  else

  end
end


result = entries.map do |entry|
  stream, output = entry.split('|')
  wires = {
    8 => %w"a b c d e f g".to_set
  }
  wire_map = {}
  2.times do
    stream.split.map(&:chars).each do |digit|
      determine_digit digit.to_set, wires, wire_map
    end
  end
  if wire_map.size == 6
    last_key = wires[8] - wire_map.keys
    last_value = wires[8] - wire_map.values
    wire_map[last_key.first] = last_value.first
  end

  #puts wires.keys.inspect
  #puts wire_map.inspect

  seriw = wires.invert.transform_keys(&:to_set)
  number = output.split.map { seriw[_1.chars.to_set] }.join.to_i
  #puts number

  #print_display(*output.tr(wire_map.values.join, wire_map.keys.join).split)
end.sum

puts result
