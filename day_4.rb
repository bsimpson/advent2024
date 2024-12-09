require "debug"

CONTENTS = File.readlines("./day_4.txt").map { |l| l.split("") }

X_LENGTH = CONTENTS[0].length - 1
Y_LENGTH = CONTENTS.length
# WORD = %w(X M A S)
WORD = %w(M A S)

occurrences = 0

def check_right(x, y, letter = WORD.first)
  # Break condition
  return true if CONTENTS[x][y] == letter && letter == WORD.last
  return false if y + 1 >= Y_LENGTH

  if CONTENTS[x][y] == letter
    return check_right(x, y + 1, WORD[WORD.index(letter).next])
  end

  false
end

def check_left(x, y, letter = WORD.first)
  # Break condition
  return true if CONTENTS[x][y] == letter && letter == WORD.last
  return false if y - 1 < 0

  if CONTENTS[x][y] == letter
    return check_left(x, y - 1, WORD[WORD.index(letter).next])
  end

  false
end

def check_down(x, y, letter = WORD.first)
  # Break condition
  return true if CONTENTS[x][y] == letter && letter == WORD.last
  return false if x + 1 >= X_LENGTH

  if CONTENTS[x][y] == letter
    return check_down(x + 1, y, WORD[WORD.index(letter).next])
  end

  false
end

def check_up(x, y, letter = WORD.first)
  # Break condition
  return true if CONTENTS[x][y] == letter && letter == WORD.last
  return false if x - 1 < 0

  if CONTENTS[x][y] == letter
    return check_up(x - 1, y, WORD[WORD.index(letter).next])
  end

  false
end

def check_up_left(x, y, letter = WORD.first)
  # Break condition
  return true if CONTENTS[x][y] == letter && letter == WORD.last
  return false if x - 1 < 0 || y - 1 < 0

  if CONTENTS[x][y] == letter
    return check_up_left(x - 1, y - 1, WORD[WORD.index(letter).next])
  end

  false
end

def check_up_right(x, y, letter = WORD.first)
  # Break condition
  return true if CONTENTS[x][y] == letter && letter == WORD.last
  return false if x - 1 < 0 || y + 1 >= Y_LENGTH

  if CONTENTS[x][y] == letter
    return check_up_right(x - 1, y + 1, WORD[WORD.index(letter).next])
  end

  false
end

def check_down_left(x, y, letter = WORD.first)
  # Break condition
  return true if CONTENTS[x][y] == letter && letter == WORD.last
  return false if x + 1 >= X_LENGTH || y - 1 < 0

  if CONTENTS[x][y] == letter
    return check_down_left(x + 1, y - 1, WORD[WORD.index(letter).next])
  end

  false
end

def check_down_right(x, y, letter = WORD.first)
  # Break condition
  return true if CONTENTS[x][y] == letter && letter == WORD.last
  return false if x + 1 >= X_LENGTH || y + 1 >= Y_LENGTH

  if CONTENTS[x][y] == letter
    return check_down_right(x + 1, y + 1, WORD[WORD.index(letter).next])
  end

  false
end

CONTENTS.each.with_index do |row, x|
  row.each.with_index do |col, y|
    # debugger
    if check_right(x, y)
      # puts "right", x, y
      occurrences += 1
    end
    if check_left(x, y)
      # puts "left", x, y
      occurrences += 1
    end
    if check_up(x, y)
      # puts "up", x, y
      occurrences += 1
    end
    if check_down(x, y)
      # puts "down", x, y
      occurrences += 1
    end
    if check_up_left(x, y)
      # puts "up/left", x, y
      occurrences += 1
    end
    if check_up_right(x, y)
      # puts "up/right", x, y
      occurrences += 1
    end
    if check_down_left(x, y)
      # puts "down/left", x, y
      occurrences += 1
    end
    if check_down_right(x, y)
      # puts "down/right", x, y
      occurrences += 1
    end
  end
end

# puts occurrences

# 2534 too low

occurrences = 0
a_positions = []

# 1 because that is the index of "A" in "M A S"- the part we are looking for an intersection
CONTENTS.each.with_index do |row, x|
  row.each.with_index do |col, y|
    if check_up_left(x, y)
      a_positions.push([x - 1, y - 1])
    end

    if check_up_right(x, y)
      a_positions.push([x - 1, y + 1])
    end

    if check_down_left(x, y)
      a_positions.push([x + 1, y - 1])
    end

    if check_down_right(x, y)
      a_positions.push([x + 1, y + 1])
    end
  end
end

puts a_positions.length - a_positions.uniq.length
# 120 too low
# 144 too low
# 1540 too low