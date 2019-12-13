class Point
  attr_reader :x, :y
  def initialize(x, y)
    @x, @y = x, y
  end

  def inspect
    "(#{x}, #{y})"
  end

  def +(other)
    self.class.new( x + other.x, y + other.y )
  end

  def ==(other)
    [ x, y ] == [ other.x, other.y ]
  end
  alias :eql? :==

  def hash
    [ x, y ].hash
  end

  def <=>(other)
    [ x, y ] <=> [ other.x, other.y ]
  end

  def to_polar(origin)
    dx = self  .x - origin.x
    dy = origin.y - self  .y # invert the Y axis
    theta = angle_in_degrees(dx, dy)
    r = Math.sqrt( dy**2 + dx**2 )
    Polar(theta, r)
  end

  def slope_to(other)
    a, b = *([ self, other ].sort)
    case
    when a.x == b.x # vertical line
      rise, run = 1, 0
    when a.y == b.y # horizontal line
      rise, run = 0, 1
    else # non-zero slope
      m = Rational( b.y - a.y, b.x - a.x )
      rise, run = m.numerator, m.denominator
    end
    Point(run, rise)
  end

  private

  def angle_in_degrees(dx, dy)
    return 0   if dx.zero? && dy.zero? # technically undefined, but whatever
    return 90  if dx.zero? && dy > 0
    return 270 if dx.zero? && dy < 0

    radians = Math.atan2(dy, dx)
    degrees = radians * 57.29578
    degrees += 360 if degrees < 0 # no negative angles, thank you
    degrees
  end
end

def Point(x, y)
  Point.new(x, y)
end
Origin = Point(0, 0)

