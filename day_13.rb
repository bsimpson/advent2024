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
# TODO remove slice - just for testing
machines.slice(0, 1).each do |machine|
  x_set = []
  x = 0
  while x <= 100 do
    # combinations a and b
    xx = 100
    while xx >= x do
      # debugger
      # debugger if (x - xx) == 80 && xx == 40
      # 5, 0
      # 4, 1
      # 3, 2
      # 2, 3,
      # 1, 4,
      # # 0, 5
      # puts "#{xx}, #{(xx - x)}"
      # puts "#{(xx - x)}, #{xx}"
      x_set << { val: (machine[:a][0] * xx) + (machine[:b][0] * (xx - x)), a: xx, b: (xx - x), cost: (xx * 3) + (xx -x) }
      x_set << { val: (machine[:a][0] * (xx - x)) + (machine[:b][0] * xx), a: (xx - x), b: xx, cost: ((xx - x) * 3) + xx }
      xx -= 1
    end
    # puts "--"

    x += 1
  end

  puts x_set.select { |x| x[:val] == (machine[:prize][0]) }
  puts x_set.length
end

