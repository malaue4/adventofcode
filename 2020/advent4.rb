input = File.read('advent4input')
input ||= <<sample
ecl:gry pid:860033327 eyr:2020 hcl:#fffffd
byr:1937 iyr:2017 cid:147 hgt:183cm

iyr:2013 ecl:amb cid:350 eyr:2023 pid:028048884
hcl:#cfa07d byr:1929

hcl:#ae17e1 iyr:2013
eyr:2024
ecl:brn pid:760753108 byr:1931
hgt:179cm

hcl:#cfa07d eyr:2025 pid:166559648
iyr:2011 ecl:brn hgt:59in
sample

passports = input.gsub(/\n\n/, '|').gsub(/\n/, ' ').split('|').map do |passport|
  passport.split(' ').to_h do |field|
    field.split(':')
  end
end

def valid?(field, value)
  case field
  when 'byr'
    value.size == 4 and value.to_i.between? 1920, 2002
  when 'iyr'
    value.size == 4 and value.to_i.between? 2010, 2020
  when 'eyr'
    value.size == 4 and value.to_i.between? 2020, 2030
  when 'hgt'
    /^(?<size>\d+)(?<unit>in|cm)$/ =~ value
    case unit
    when 'in'
      size.to_i.between? 59, 76
    when 'cm'
      size.to_i.between? 150, 193
    else
      false
    end
  when 'hcl'
    value.match? /^#[a-f0-9]{6}$/
  when 'ecl'
    value.match? /^(amb|blu|brn|gry|grn|hzl|oth)$/
  when 'pid'
    value.match? /^\d{9}$/
  end
end

required_keys = %w[byr iyr eyr hgt hcl ecl pid]
valid_passports = passports.select do |pp|
  required_keys.all?{ |it| pp.key?(it) and valid?(it, pp[it]) }
end

puts valid_passports, valid_passports.count