class OrbitMap
  class Object
    attr_reader :name, :in_orbit_around
    def initialize(name)
      @name = name
    end

    def orbits(object)
      @in_orbit_around = object
    end

    def orbit_count
      orbiting.length
    end

    def orbiting
      @_orbiting ||=
        if in_orbit_around
          [ in_orbit_around ] + in_orbit_around.orbiting
        else
          []
        end
    end

    def hops_to(object)
      orbiting.index(object)
    end

    def inspect
      "<#{name}>"
    end
  end

  def initialize(listing)
    @objects = {}
    populate_objects(listing)
  end

  def object_named(name)
    @objects[name] ||= Object.new(name)
  end

  def object_names
    @objects.keys.sort
  end

  def object_count
    @objects.length
  end

  def orbit_count
    @objects.values.inject(0) { |mem, obj| mem + obj.orbit_count }
  end

  def minimum_transfers(from:, to:)
    a, b = object_named(from), object_named(to)
    x = (a.orbiting & b.orbiting).first
    a.hops_to(x) + b.hops_to(x)
  end

  private

  def populate_objects(listing)
    listing.strip.lines.each do |line|
      lft, rgt = *line.split(")").map(&:strip)
      a = object_named(lft)
      b = object_named(rgt)
      b.orbits a
    end
  end
end
