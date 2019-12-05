
class Path
  def self.from_string(path_string)
    new.tap do |path|
      path_string.split(",").each do |vector_string|
        path.extend(vector_string)
      end
    end
  end

  def vectors
    @_vectors ||= []
  end

  def extend(vector)
    vectors << Vector.for(vector)
  end

  def &(other)
    self.points & other.points
  end

  def points
    list = []
    vectors.each do |v|
      tail = list.last || Origin
      list.concat tail.points_along(v)
    end
    list.uniq
  end

  def inspect
    turning_points.map(&:inspect).join( " --> " )
  end

  # Not especially useful outside of #inspect
  def turning_points
    list = [ Point(0, 0) ]
    vectors.each do |v|
      list << list.last.add(v)
    end
    list
  end
end
