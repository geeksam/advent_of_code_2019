require_relative 'day3/point'
require_relative 'day3/vector'
require_relative 'day3/path'



module CrossedWires
  extend self

  def distance_to_closest_intersection(path1, path2)
    intersections = (path1 & path2)
    intersections.delete Origin
    distances = intersections.map(&:manhattan_distance)
    distances.min
  end
end
