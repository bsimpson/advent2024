class DaySix
  OBSTACLE = "#"

  def initialize
    @contents = File.readlines("./day_6.txt").map { |r| r.chomp.split("") }

    @length = @contents[0].length
    @height = @contents.length - 1

    @visited = []

    @start_at = nil
    @contents.each.with_index do |r, x|
      r.each.with_index do |c, y|
        @start_at = [x, y] if @contents[x][y] == "^"
      end
    end
    @detected_loops = 0
  end

  def part_one
    walk(*@start_at, "up")

    # puts @visited.inspect
    puts "Unique visits: ", @visited.map {|x| x.slice(0, 2) }.uniq.length
  end

  def part_two
    @contents.each.with_index do |r, x|
      puts "row: #{x}"
      r.each.with_index do |c, y|
        puts "column: #{y}"
        next if ["^", "#"].include?(c)

        @contents[x][y] = "#"

        @visited.clear
        walk(*@start_at, "up")

        # restore
        @contents[x][y] = "."
      end
    end

    puts "Loops: ", @detected_loops
  end

  def walk(x, y, direction = "up")
    if @visited.include?([x, y, direction])
      @detected_loops += 1
      puts @detected_loops
      return
    end

    @visited.push([x, y, direction])

    case direction
    when "up"
      if x - 1 < 0
        return
      elsif @contents[x - 1][y] == OBSTACLE
        walk(x, y, "right")
      else
        walk(x - 1, y, direction)
      end

    when "right"
      if y + 1 > @length
        return
      elsif @contents[x][y + 1] == OBSTACLE
        walk(x, y, "down")
      else
        walk(x, y + 1, direction)
      end

    when "down"
      if x + 1 > @height
        return
      elsif @contents[x + 1][y] == OBSTACLE
        walk(x, y, "left")
      else
        walk(x + 1, y, direction)
      end

    when "left"
      if y - 1 < 0
        return
      elsif @contents[x][y - 1] == OBSTACLE
        walk(x, y, "up")
      else
        walk(x, y - 1, direction)
      end
    end
  end
end

DaySix.new.part_two
# 226 too low