draws_input, bingos_input = File.read('advent4input').split("\n", 2)
bingo_boards = bingos_input.split("\n\n")
draws = draws_input.split(",")

class BingoBoard
  attr_reader :fields

  def initialize(input)
    @fields = input.scan(/\d+/)
  end

  def rows
    @rows ||= fields.each_slice(5).to_a
  end

  def columns
    @columns ||= rows.transpose
  end

  def wins_in(draws)
    (rows + columns).map { |line| line.map { draws.find_index(_1) }.max }.min
  end

  def unmarked_numbers(draws)
    end_at = wins_in(draws)
    fields - draws[..end_at]
  end

  def winning_number(draws)
    end_at = wins_in(draws)
    draws[end_at]
  end
end

first_winner = bingo_boards.map do |bb|
  BingoBoard.new(bb)
end.min_by { _1.wins_in(draws) }

last_winner = bingo_boards.map do |bb|
  BingoBoard.new(bb)
end.max_by { _1.wins_in(draws) }

puts "First winning board result",
     first_winner.unmarked_numbers(draws).map(&:to_i).sum * first_winner.winning_number(draws).to_i
puts "Last winning board result",
     last_winner.unmarked_numbers(draws).map(&:to_i).sum * last_winner.winning_number(draws).to_i
