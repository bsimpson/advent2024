array_1 = []
array_2 = []

File.readlines("./day_1.txt").each do |line|
  parts = line.split("   ")
  array_1.push(parts[0].to_i)
  array_2.push(parts[1].to_i)
end

array_1.sort!
array_2.sort!

distance_sum = 0

array_1.each.with_index do |num, idx|
  distance_sum += (num - array_2[idx]).abs
end

# puts distance_sum

similarty_score = 0

array_1.each.with_index do |num, idx|
  similarty_score += (num * array_2.select { |x| x === num }.length)
end

puts similarty_score