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
    @_points ||=
      begin
        list = [Origin]
        vectors.each do |v|
          tail = list.last
          list.concat tail.points_along(v)[1..-1]
        end
        list
      end
  end

  def steps_to(point)
    points.index(point)
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
