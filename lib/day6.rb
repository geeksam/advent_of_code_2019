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
      if in_orbit_around
        in_orbit_around.orbit_count + 1
      else
        0
      end
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
