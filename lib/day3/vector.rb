class Vector
  attr_reader :dir, :len, :unit
  def initialize(dir, len)
    @dir = dir
    @len = len.to_i
    fail ArgumentError, "IDK what to do with Vector.new(#{dir}, #{len})" if unit.nil?
  end

  def self.for(vector_or_string)
    case vector_or_string
    when String
      md = vector_or_string.match( /([URDL])(\d+)/ )
      new(*md.captures)
    when self
      vector_or_string
    else
      fail ArgumentError
    end
  end

  UNIT_POINTS = {
    "U" => Point(  0,  1 ),
    "R" => Point(  1,  0 ),
    "D" => Point(  0, -1 ),
    "L" => Point( -1,  0 ),
  }

  def unit
    UNIT_POINTS[dir]
  end

  def to_point
    unit * len
  end

  def inspect
    "Vector(#{dir}, #{len})"
  end
end
