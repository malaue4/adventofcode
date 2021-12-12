diagnostics = File.read('advent3input').split("\n")


life_support_rating = ""
12.times.reduce(diagnostics) do |remaining_diags, i|
  if remaining_diags.size == 1
    life_support_rating = remaining_diags.first
    break
  end

  column = remaining_diags.map { _1.chars[i] }
  tally = column.tally
  if tally['1'] >= tally['0']
    life_support_rating << '1'
  else
    life_support_rating << '0'
  end

  remaining_diags.select { _1.start_with? life_support_rating }
end
puts life_support_rating.to_i(2)

oxygen_generator_rating = ""
12.times.reduce(diagnostics) do |remaining_diags, i|
  if remaining_diags.size == 1
    oxygen_generator_rating = remaining_diags.first
    break
  end

  column = remaining_diags.map { _1.chars[i] }
  tally = column.tally
  if tally['1'] < tally['0']
    oxygen_generator_rating << '1'
  else
    oxygen_generator_rating << '0'
  end

  remaining_diags.select { _1.start_with? oxygen_generator_rating }
end
puts oxygen_generator_rating.to_i(2)
puts life_support_rating.to_i(2)*oxygen_generator_rating.to_i(2)