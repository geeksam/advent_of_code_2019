require 'set'

class BugBoard
  def self.biodiversity_score(board_text)
    new(board_text).biodiversity_score
  end

  def initialize(board_text)
    @rows = []
    board_text.lines.each do |line|
      @rows << row = []
      line.scan(/./) do |char|
        row << ( char == '#' ? :bug : nil )
      end
    end
  end

  def to_s
    s = ""
    @rows.each do |row|
      row.each do |cell|
        s << ( cell == :bug ? "#" : "." )
      end
      s << "\n"
    end
    s.strip
  end

  def at(x,y)
    row = @rows[y]
    fail IndexError, "wtf is this (#{x}, #{y})?" if row.nil?
    row[x]
  end

  def neighbors_of(x, y)
    list = []
    list << [ x,   y-1 ] unless y == 0 # north
    list << [ x+1, y   ] unless x == 4 # east
    list << [ x,   y+1 ] unless y == 4 # south
    list << [ x-1, y   ] unless x == 0 # west
    list
  end

  def tick
		next_rows = []
    (0..4).each do |y|
      next_rows << row = []
      (0..4).each do |x|
        bug_count = neighbors_of(x,y).map { |xy| at(*xy) }.compact.length
        if at(x, y) == :bug
           row << ( bug_count == 1 ? :bug : nil )
        else
           row << ( bug_count == 1 || bug_count == 2 ? :bug : nil )
        end
      end
    end
    @rows = next_rows
  end

  def first_repeated_layout
    orig_rows = @rows
    layout = nil

    @layouts_seen = Set.new
    loop do
      layout = to_s
      break if @layouts_seen.include?(layout)
      @layouts_seen << layout
      tick
    end

    @rows = orig_rows

    layout
  end

  def biodiversity_score
    n = 1
    score = 0
    @rows.flatten.each do |value|
      score += n if value == :bug
      n *= 2
    end
    score
  end
end
