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
