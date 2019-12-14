class Vector
  attr_reader :x, :y, :z
  def initialize(x, y, z)
    @x, @y, @z = x, y, z
  end

  def components
    [ x, y, z ]
  end

  def +(other)
    self.class.new( x+other.x, y+other.y, z+other.z )
  end

  def ==(other)
    components == other.components
  end
  alias :eql? :==

  def hash
    components.hash
  end

  def inspect
    "<x=%3d, y=%3d, z=%3d>" % components
  end
end
def Vector(x, y, z)
  Vector.new(x, y, z)
end

class Body
  attr_accessor :position, :velocity
  attr_accessor :name
  def initialize(x, y, z)
    @position = Vector(x, y, z)
    @velocity = Vector(0, 0, 0)
  end

  def update_position
    self.position += velocity
  end

  def potential_energy
    position.components.map(&:abs).inject(0, &:+)
  end

  def kinetic_energy
    velocity.components.map(&:abs).inject(0, &:+)
  end

  def total_energy
    potential_energy * kinetic_energy
  end
end

class System
  attr_reader :bodies
  def initialize(*bodies)
    @bodies = Array(bodies).flatten
  end

  def step
    add_gravity
    update_positions
  end

  def total_energy
    bodies.map(&:total_energy).inject(0, &:+)
  end

  def to_s
    bodies.map { |body|
      "pos=#{body.position.inspect}, vel=#{body.velocity.inspect}"
    }.join("\n")
  end

  private

  def add_gravity
    n = bodies.length-1
    (0...n).each do |i|
      ((i+1)..n).each do |j|
        a, b = bodies[i], bodies[j]
        a_delta, b_delta = gravity_deltas(a.position, b.position)
        a.velocity += a_delta
        b.velocity += b_delta
      end
    end
  end

  def update_positions
    bodies.each(&:update_position)
  end

  def gravity_deltas(a, b)
    ax, bx = component_gravity_deltas(a.x, b.x)
    ay, by = component_gravity_deltas(a.y, b.y)
    az, bz = component_gravity_deltas(a.z, b.z)
    da = Vector(ax, ay, az)
    db = Vector(bx, by, bz)
    return da, db
  end

  # Takes an individual component of two vectors and provides the delta for that component
  def component_gravity_deltas(c1, c2)
    case
    when c1 < c2 ; [  1, -1 ]
    when c1 > c2 ; [ -1,  1 ]
    else         ; [  0,  0 ]
    end
  end
end
