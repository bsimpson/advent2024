contents = File.readlines("./day_3.txt").join("")

regexp = /(mul\((\d{,3}),(\d{,3})\))/
# sum = 0
# contents.scan(regexp).each do |n|
#   sum += (n[1].to_i * n[2].to_i)
# end

# puts sum

dont_regexp = /don't\(\).*?(?=do\(\)|$)/

binding.irb
contents.gsub!(dont_regexp, "")

sum = 0
contents.scan(regexp).each do |n|
  sum += (n[1].to_i * n[2].to_i)
end

puts sum
# 53984975 too low
# 69346806 too high
# 90085625 too high