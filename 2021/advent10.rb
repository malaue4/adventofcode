inputs = File.read('advent10input').lines(chomp: true)
inputs ||= <<lines.lines(chomp: true)
[({(<(())[]>[[{[]{<()<>>
[(()[<>])]({[<{<<[]>>(
{([(<{}[<>[]}>{[]{[(<()>
(((({<>}<{<{<>}{[]{[]{}
[[<[([]))<([[{}[[()]]]
[{[{({}]{}}([{[{{{}}([]
{<[[]]>}<{[{[{[]{()[[[]
[<(<(<(<{}))><([]([]()
<{([([[(<>()){}]>(<<{{
<{([{{}}[<[[[<>{}]]]>[]]
lines

OPENER = %w'( [ { <'.freeze
CLOSER = %w') ] } >'.freeze
CHUNKS = OPENER.zip(CLOSER).to_h
errors = []
auto_completes = []
inputs.each do |input|
  chunks = []
  catch(:syntax_error) do
    input.each_char do |char|
      case char
      when *OPENER
        chunks << char
      when *CLOSER
        opener = chunks.pop
        expected = CHUNKS[opener]
        if expected != char
          puts "unmatched '#{opener}' found, expected '#{expected}' got '#{char}'"
          errors << char
          throw :syntax_error
        end
      end
    end
    unless chunks.empty?
      puts "incomplete input found '#{input}'"
      auto_completes << chunks.reverse.map { |opener| CHUNKS[opener] }
    end
  end
end

ERROR_SCORES = {
  ')' => 3,
  ']' => 57,
  '}' => 1197,
  '>' => 25137
}.freeze

AUTOCOMPLETE_SCORES = {
  ')' => 1,
  ']' => 2,
  '}' => 3,
  '>' => 4
}.freeze
puts "Error score is: #{ERROR_SCORES.fetch_values(*errors).sum}"

auto_completes_scores = auto_completes.map do |auto_complete|
  score = AUTOCOMPLETE_SCORES.fetch_values(*auto_complete).reduce(0) do |sum, character_value|
    sum * 5 + character_value
  end
  score
end

puts "Autocomplete score is: #{auto_completes_scores.sort[auto_completes.size/2]}"