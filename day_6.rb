CONTENTS = File.readlines("./day_6.txt").map { |r| r.chomp.split("") }

LENGTH = CONTENTS[0].length
HEIGHT = CONTENTS.length - 1
OBSTACLE = "#"

VISITED = []
start_at = nil
CONTENTS.each.with_index do |r, x|
  r.each.with_index do |c, y|
    start_at = [x, y] if CONTENTS[x][y] == "^"
  end
end

def walk(x, y, direction = "up")
  VISITED.push([x, y])

  case direction
  when "up"
    if x - 1 < 0
      return
    elsif CONTENTS[x - 1][y] == OBSTACLE
      walk(x, y, "right")
    else
      walk(x - 1, y, direction)
    end

  when "right"
    if y + 1 > LENGTH
      return
    elsif CONTENTS[x][y + 1] == OBSTACLE
      walk(x, y, "down")
    else
      walk(x, y + 1, direction)
    end

  when "down"
    if x + 1 > HEIGHT
      return
    elsif CONTENTS[x + 1][y] == OBSTACLE
      walk(x, y, "left")
    else
      walk(x + 1, y, direction)
    end

  when "left"
    if y - 1 < 0
      return
    elsif CONTENTS[x][y - 1] == OBSTACLE
      walk(x, y, "up")
    else
      walk(x, y - 1, direction)
    end
  end
end

walk(*start_at, "up")

puts VISITED.inspect
puts VISITED.uniq.length

# 226 too low