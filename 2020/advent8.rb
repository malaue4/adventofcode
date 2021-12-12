input = File.read('advent8input').lines(chomp: true)
sample = <<sample.lines(chomp: true)
nop +0
acc +1
jmp +4
acc +3
jmp -3
acc -99
acc +1
jmp -4
acc +6
sample
instructions = input.map(&:split).map { [_1, _2.to_i] }
puts instructions.inspect

def halt?(instructions)
  ran_instructions = []
  head = 0
  acc = 0
  until ran_instructions.include? head
    instruction, argument = instructions[head]
    #puts "#{instruction} #{argument} \t | #{head} | #{acc}"
    ran_instructions << head
    case instruction
    when 'nop'
      head += 1
    when 'acc'
      acc += argument
      head += 1
    when 'jmp'
      head += argument
    else
      puts acc
      return true
    end
  end

  false
end

instructions.each_with_index.select do |(instruction, argument), index|
  instruction == 'jmp' or (instruction == 'nop' and argument != 0)
end.each do |(instruction, argument), index|
  modified_instructions = instructions.dup
  modified_instructions[index] = [instruction == 'nop' ? 'jmp' : 'nop', argument]
  if halt? modified_instructions
    puts "Program halted after switching instruction on line #{index}"
    break
  end
end