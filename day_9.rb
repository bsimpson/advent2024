require "debug"

# contents = "12345"
# contents = "2333133121414131402"
contents = File.read("./day_9.txt")
contents = contents.split("")

puts "contents"#, contents

blocks = []
# 0..111....22222
contents.each.with_index do |file_id, idx|
  if (idx % 2 != 0)
    blocks.push ["."] * (file_id.to_i)
  else
    blocks.push [(idx / 2).to_s] * file_id.to_i
  end
end

part2_blocks = blocks

blocks = blocks.flatten#.join("").split("")
puts "blocks", blocks.inspect

# 022111222......
# blocks.each.with_index do |b, idx|
#   first_space_pos = blocks.index(".")
#   last_char_pos = blocks.rindex { |bb| bb != "." }

#   break if first_space_pos >= last_char_pos
#   blocks[first_space_pos] = blocks[last_char_pos]
#   blocks[last_char_pos] = "."
# end

# Faster but still doesn't work file id > 9
# compacted = Array.new(blocks.length)
# non_empty_blocks = blocks.select { |x| x != "." }
# x = non_empty_blocks.length - 1
# blocks.length.times do |idx|
#   # debugger
#   break if idx > x

#   if blocks[idx] != "."
#     compacted[idx] = blocks[idx]
#   else
#     compacted[idx] = non_empty_blocks.pop
#   end
# end

compacted = Array.new(blocks.length)
non_empty_blocks = blocks.select { |x| x[0] != "." }
x = non_empty_blocks.length - 1
blocks.length.times do |idx|
  # debugger
  break if idx > x

  if blocks[idx][0] != "."
    compacted[idx] = blocks[idx]
  else
    compacted[idx] = non_empty_blocks.pop
  end
end
puts "compacted", compacted.inspect

# sum = 0
# blocks.each do |n|
#   sum += n.to_i
# end
# puts sum

# sum = 0
# compacted.each do |n|
#   sum += n.to_i
# end
# puts sum

sum = 0
compacted.each_with_index do |n, idx|
  next if n == 0
  sum += n.to_i * idx
end

puts "checksum", sum
# 89947706548 too low

# PART 2
blocks = part2_blocks
compacted = blocks
# non_empty_blocks = blocks.select { |x| x[0] != "." }
# x = non_empty_blocks.length - 1
# blocks.each.with_index do |block, idx|
#   debugger

#   if block.any? {|x| == "." }
#     if (a = blocks[blocks.length - idx].length) <= b = block.length # 2222 <= ....
#       c = blocks[blocks.length - idx].fill(".", a, b - a)
#       compacted[idx] = c
#     end
#   else
#     compacted[idx] = block
#   end
# end

blocks.reverse.each.with_index do |block, idx|

  next if block.empty? || block.all? {|x| x == "." }

  # leftmost span of free space blocks that could fit the file
  c_idx = compacted.index {|x| x.select {|xx| xx == "." }.length >= block.length }


  if c_idx
    # debugger
    # no free placement to the left of the current index
    next if c_idx > compacted.length - 1 - idx

    mutable_block = block.dup
    new_block = compacted[c_idx].map.with_index do |c, ii|
      # take char from destination block
      if c != "."
        c
      # fill in with source block
      elsif mutable_block.length > 0
        mutable_block.shift
      else
        # fill in remaining destination space
        "."
      end
    end
    compacted[c_idx] = new_block

    compacted[compacted.length - 1 - idx].fill(".")
  end
end

puts compacted.join("")

sum = 0
compacted.flatten.each_with_index do |n, idx|
  next if n == 0
  sum += n.to_i * idx
end

puts "checksum", sum