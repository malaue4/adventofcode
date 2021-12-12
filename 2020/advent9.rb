input = File.read('advent9input').lines(chomp: true)

sample = <<sample.lines(chomp: true)
35
20
15
25
47
40
62
55
65
95
102
117
150
182
127
219
299
277
309
576
sample

def validate(input, window_size)
  top, it = 0, 0
  bot, ib = window_size-1, window_size-1
  target = input[window_size]
  while bot < input.size
    if it == bot
      puts "#{target} is invalid"
      return false
    elsif input[it] + input[ib] == target or puts("#{input[it]} + #{input[ib]} == #{input[it] + input[ib]}")
      puts "#{target} is valid"
      top += 1
      bot += 1
      it, ib = top, bot
      target = input[bot+1]
      puts "moving on to #{target}, using #{input[top..bot]}"
    else
      ib -= 1
      if ib == it
        ib = bot
        it += 1
      end
    end
  end

  true
end

def find_range(input, target)
  input.each_cons(2).with_index do |_, start|
    stop = start+1
    while input[start..stop].sum <= target
      return input[start..stop] if input[start..stop].sum == target

      stop += 1
    end
  end
end

#puts validate(input.map(&:to_i), 25)
smallest, largest = find_range(input.map(&:to_i), 248131121).minmax
puts smallest, largest, smallest+largest