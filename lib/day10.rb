require 'forwardable'

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
end

def Point(x, y)
  Point.new(x, y)
end
Origin = Point(0, 0)

class Asteroid
  attr_reader :map, :point
  def initialize(map, point)
    @map   = map
    @point = point
  end

  extend Forwardable
  def_delegators :point, :x, :y

  def inspect
    "<Asteroid #{point.inspect})>"
  end

  def to_point
    point
  end

  def <=>(other)
    self.point <=> other.point
  end

  def can_see?(other)
    map.clear_line_of_sight_between?(self.point, other.point)
  end
end

class AsteroidMap
  def self.from_text(text)
    new.tap do |map|
      text.strip.lines.each.with_index do |line, y|
        line.scan(/./).each.with_index do |char, x|
          if char == '#'
            point = Point(x,y)
            map[point] = Asteroid.new(map, point)
          end
        end
      end
    end
  end

  def initialize
    @roids = {}
  end

  def []=(point, object)
    @roids[point] = object
  end

  def [](point)
    @roids[point]
  end

  def points_between(a, b)
    a, b = *([ a, b ].sort)

    slope = a.slope_to(b)

    points = []
    point = a
    until point == b do
      point += slope
      points << point
    end

    (points - [a,b]).sort
  end

  def objects_between(a, b)
    objects = []
    points_between(a, b).each do |point|
      objects << self[point]
    end
    objects.compact.sort
  end

  def clear_line_of_sight_between?(a, b)
    objects_between(a, b).empty?
  end

  def asteroids_detectable_from(point)
    # FIXME: this might slow things down too much in a loop
    other_roids = @roids.values - [self[point]]
    detectable = other_roids.select { |roid| clear_line_of_sight_between?(point, roid.point) }
    detectable
  end

  def num_asteroids_detectable_from(point)
    asteroids_detectable_from(point).length
  end

  def optimal_monitoring_location
    roids = @roids.values
    roids_with_scores = roids.map { |roid| [ roid, num_asteroids_detectable_from(roid.point) ] }
    roid, score = *roids_with_scores.sort_by(&:last).last
    return roid.point, score
  end
end
