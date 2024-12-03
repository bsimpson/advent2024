levels = File.readlines("./day_2.txt").map do |row|
  row.split(" ").map(&:to_i)
end

def safe_increase(array)
  # given [7, 6, 4, 2, 1]
  # generate new arrays with one entity removed
  # [6, 4, 2, 1],
  # [7, 4, 2, 1],
  # [7, 6, 2, 1],
  # [7, 6, 4, 1],
  # [7, 6, 4, 2],
  new_arrays = array.length.times.with_index.map do |_, idx|
    Array.new(array).tap { |a| a.delete_at(idx) }
  end

  # original array
  new_arrays.push(array)

  new_arrays.any? { |a| all_within_three(a) }
end

def all_within_three(array)
  array.each.with_index do |n, idx|
    return true unless array[idx + 1]

    return false unless (1..3).include?(array[idx + 1] - n)
  end

  true
end

puts levels.select { |l| safe_increase(l) || safe_increase(l.reverse) }.length