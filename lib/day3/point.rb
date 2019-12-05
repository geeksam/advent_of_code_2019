class Point
  def self.from_vector(vector)
    Vector.for(vector).to_point
  end

  attr_reader :x, :y
  def initialize(x, y)
    @x, @y = x, y
  end

  def add(vector)
    self + self.class.from_vector(vector)
  end

  def manhattan_distance
    x.abs + y.abs
  end

  def points_along(vector)
    v = Vector.for(vector)
    Array.new.tap do |list|
      0.upto(v.len) do |i|
        delta = v.unit * i
        list << self + delta
      end
    end
  end

  def ==(other)
    [ x, y ] == [ other.x, other.y ]
  end
  alias :eql? :==

  def hash
    [ x, y ].hash
  end

  def *(other)
    case other
    when Integer ; self.class.new( x * other,   y * other )
    when Point   ; self.class.new( x * other.x, y * other.y )
    else         ; fail ArgumentError
    end
  end

  def +(other)
    self.class.new( x + other.x, y + other.y )
  end

  def inspect
    "Point(#{x}, #{y})"
  end
end

def Point(x, y)
  Point.new(x, y)
end
Origin = Point(0, 0)
