require_relative 'day3/point'
require_relative 'day3/vector'
require_relative 'day3/path'



module CrossedWires
  extend self

  def distance_to_closest_intersection(path1, path2)
    intersections(path1, path2).map(&:manhattan_distance).min
  end

  def steps_to_fastest_intersection(path1, path2)
    distance = ->(point) { path1.steps_to(point) + path2.steps_to(point) }
    list = intersections(path1, path2)
    list_with_steps = list.map { |e| [ distance.(e), e ] }
    list_with_steps.sort_by!(&:first)
# puts; pp list_with_steps
    steps, _point = *list_with_steps.first
    steps
  end

  private

  def intersections(path1, path2)
    (path1 & path2).tap do |list|
      list.delete Origin
    end
  end
end
