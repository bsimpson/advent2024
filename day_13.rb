require "debug"

contents = <<~CONTENTS
Button A: X+94, Y+34
Button B: X+22, Y+67
Prize: X=8400, Y=5400

Button A: X+26, Y+66
Button B: X+67, Y+21
Prize: X=12748, Y=12176

Button A: X+17, Y+86
Button B: X+84, Y+37
Prize: X=7870, Y=6450

Button A: X+69, Y+23
Button B: X+27, Y+71
Prize: X=18641, Y=10279
CONTENTS

contents = File.read("./day_13.txt")

machines = contents.split("\n\n").map do |machine|
  lines = machine.split("\n")
  {
    a: [
      lines[0].match(/X\+(\d*)/)[1].to_i,
      lines[0].match(/Y\+(\d*)/)[1].to_i
    ],
    b: [
      lines[1].match(/X\+(\d*)/)[1].to_i,
      lines[1].match(/Y\+(\d*)/)[1].to_i
    ],
    prize: [
      lines[2].match(/X=(\d*)/)[1].to_i,
      lines[2].match(/Y=(\d*)/)[1].to_i
    ]
  }
end

# puts machines.inspect
costs = machines.map do |machine|
  x_set = []
  x = 0
  while x <= 100 do
    # combinations a and b
    xx = 100
    while xx >= x do
      x_set << {
        xval: (machine[:a][0] * xx) + (machine[:b][0] * (xx - x)),
        yval: (machine[:a][1] * xx) + (machine[:b][1] * (xx - x)),
        a: xx,
        b: (xx - x),
        cost: (xx * 3) + (xx -x)
      }
      x_set << {
        xval: (machine[:a][0] * (xx - x)) + (machine[:b][0] * xx),
        yval: (machine[:a][1] * (xx - x)) + (machine[:b][1] * xx),
        a: (xx - x),
        b: xx,
        cost: ((xx - x) * 3) + xx
      }
      xx -= 1
    end

    x += 1
  end

  valid_inputs = x_set.select { |x| x[:xval] == (machine[:prize][0]) && x[:yval] == (machine[:prize][1]) }
  if valid_inputs.empty?
    0
  else
    valid_inputs.min_by { |x| x[:cost] }[:cost]
  end
end

puts costs.inspect

# sum up all costs
puts costs.inject(0, :+)