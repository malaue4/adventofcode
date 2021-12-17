input = File.read('advent16input').lines(chomp: true)
sample = <<sample.lines(chomp: true)
D2FE28
38006F45291200
EE00D40C823060
8A004A801A8002F478
620080001611562C8802118E34
C0015000016115A2E0802F182340
A0016C880162017C3686B18A3D4780
sample

class String
  # colorization
  def colorize(color_code)
    "\e[#{color_code}m#{self}\e[0m"
  end

  def red
    colorize(31)
  end

  def green
    colorize(32)
  end

  def yellow
    colorize(33)
  end

  def blue
    colorize(34)
  end

  def pink
    colorize(35)
  end

  def light_blue
    colorize(36)
  end
end

class LiteralPacket < Struct.new :version, :value, :input
  def type
    4
  end

  def self.parse(binary)
    version, _type = binary[0..2].to_i(2), binary[3..5].to_i(2)

    parts = 0
    last = false
    number = ""
    until last
      packet = binary[6+parts*5...6+parts*5+5]
      last = packet[0] == '0'
      number << packet[1..]
      parts += 1
    end

    [new(version, number.to_i(2), colored_input(binary[0..6+parts*5])), 6+parts*5]
  end

  def self.colored_input(input)
    [
      input[0..2].red,
      input[3..5].green,
      input[6..].each_char.each_slice(5).map do |pack|
        [
          pack[0].light_blue,
          pack[1..].join.blue
        ].join
      end
    ].join
  end
end

class OperatorPacket < Struct.new :version, :type, :input, :packets

  def self.parse(binary)
    version, type = binary[0..2].to_i(2), binary[3..5].to_i(2)
    packet = new(version, type)
    bits_read = 6
    case binary[6]
    when '0'
      packet_size = binary[7...22].to_i(2)
      bits_read += 16
      bits_read += packet.parse_packets(binary[22..], bit_limit: packet_size)
    when '1'
      packet_count = binary[7...18].to_i(2)
      bits_read += 12
      bits_read += packet.parse_packets(binary[18..], packet_limit: packet_count)
    else
      raise ArgumentError, 'missing length type'
    end

    packet.input = packet.colored_input(binary[0..bits_read])
    [packet, bits_read]
  end

  def parse_packets(binary, packet_limit: nil, bit_limit: nil)
    self.packets = []
    head = 0
    until packets.size == packet_limit || (!bit_limit.nil? && bit_limit <= head)
      _version, type = binary[head..head+2], binary[head+3..head+5]
      if type.to_i(2) == 4
        packet, bits_read = LiteralPacket.parse(binary[head..])
        break if bits_read == 0
        head += bits_read
      else # operator
        packet, bits_read = OperatorPacket.parse(binary[head..])
        break if bits_read == 0
        head += bits_read
      end
      packets << packet
    end

    head
  rescue
    puts head, binary
  end

  def value
    @value ||= case type
    when 0
      packets.map(&:value).sum
    when 1
      packets.map(&:value).reduce(:*)
    when 2
      packets.map(&:value).min
    when 3
      packets.map(&:value).max
    when 5
      first, second = packets.map(&:value)
      first > second ? 1 : 0
    when 6
      first, second = packets.map(&:value)
      first < second ? 1 : 0
    when 7
      first, second = packets.map(&:value)
      first == second ? 1 : 0
    end
  end

  def colored_input(input)
    lt = input[6] == '0' ? 15 : 11
    [
      input[0..2].red,
      input[3..5].green,
      input[6].yellow,
      input[7...7+lt].pink,
      input[7+lt..].blue
    ].join
  end
end

def print_result(packet, indent='')
  version_sum = packet.version
  case packet
  when LiteralPacket
    puts "#{indent} LP Version=#{packet.version}, Type=#{packet.type}, Value=#{packet.value}, Input=#{packet.input}"
  when OperatorPacket
    puts "#{indent} OP Version=#{packet.version}, Type=#{packet.type}, Value=#{packet.value}, Input=#{packet.input}"
    packet.packets.each do |sub_packet|
      version_sum += print_result(sub_packet, indent+'  ')
    end
  end

  version_sum
end

sample = <<sample.lines(chomp: true)
C200B40A82
04005AC33890
880086C3E88112
CE00C43D881120
D8005AC2A8F0
F600BC2D8F
9C005AC2F8F0
9C0141080250320F1802104A08
sample

input.each_with_index do |line, i|
  binary = line.chomp.each_char.map { |it| '%4.4b' % it.to_i(16) }.join
  version, type = binary[0..2].to_i(2), binary[3..5].to_i(2)

  puts "Sample #{i}: #{line}"
  case type
  when 4 # literal value
    packet, end_index = LiteralPacket.parse(binary)
  else # operator
    packet, end_index = OperatorPacket.parse(binary)
  end

  puts print_result(packet)
end
