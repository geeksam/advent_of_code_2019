require 'forwardable'
require_relative "day10/point"
require_relative "day10/polar"
require_relative "day10/asteroid"

class AsteroidMap
  def self.from_text(text)
    new.tap do |map|
      text.strip.lines.each.with_index do |line, y|
        line.scan(/./).each.with_index do |char, x|
          point = Point(x,y)
          case char
          when 'X' ; map.polar_origin = point
          when '#' ; map[point] = Asteroid.new(map, point)
          end
        end
      end
    end
  end

  attr_accessor :polar_origin
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

  def annihilation_queue
    fail "no laser present!" if polar_origin.nil?

    data = Hash.new { |hash, key| hash[key] = [] }
    @roids.keys.each do |point|
      polar = point.to_polar(polar_origin)
      data[polar.theta] << [ polar, point ]
    end
    data.values.each(&:sort!) # they're already grouped by theta; this sorts them by radius

    thetas = data.keys.sort
    thetas.reverse! # going CW instead of CCW
    q1, rest = thetas.partition { |e| (0..90).cover?(e) }
    thetas = q1 + rest

    queue = []
    k = nil
    loop do
      thetas.each do |theta|
        target = data[theta].shift
        next if target.nil?
        queue << target.last
      end
      break if queue.length == k # made it all the way around without vaporizing anything
      k = queue.length
    end

    queue
  end
end
