import math
import re

def distance_to_closest_intersection(path1, path2):
    ints = path1.intersections(path2)
    dists = map(lambda path: path.manhattan_distance(), ints)
    return min(dists)

def steps_to_fastest_intersection(path1, path2):
    distance = lambda pt: [ path1.steps_to(pt) + path2.steps_to(pt), pt ]
    ints = path1.intersections(path2)
    list_with_steps = list(map(distance, ints))
    list_with_steps.sort(key=lambda x: x[0])
    steps, _point = list_with_steps[0]
    return steps

class Vector:
    def __init__(self, vector_or_string):
        if isinstance(vector_or_string, str):
            m = re.match(r"([URDL])(\d+)", vector_or_string)
            direction = m.group(1)
            length = int(m.group(2))
            self.direction, self.length = direction, length
        elif isinstance(vector_or_string, self.__class__):
            self.direction = vector_or_string.direction
            self.length    = vector_or_string.length
        else:
            raise "IDKWTF"

    def unit(self):
        if self.direction == "U": return Point(  0,  1 )
        if self.direction == "R": return Point(  1,  0 )
        if self.direction == "D": return Point(  0, -1 )
        if self.direction == "L": return Point( -1,  0 )
        raise "IDKWTF"

    def to_point(self):
        return self.unit() * self.length

    def __eq__(self, other):
        return self.direction == other.direction and self.length == other.length

    def __repr__(self):
        return f"Vector('{self.direction}{self.length}')"

class Point:
    def __init__(self, x, y):
        self.x, self.y = x, y

    def manhattan_distance(self):
        return math.fabs(self.x) + math.fabs(self.y)

    def points_along(self, vector_string):
        v = Vector(vector_string)
        points = []
        for i in range(0, v.length+1):
            delta = v.unit() * i
            p = self + delta
            points.append(p)
        return points

    def __repr__(self):
        return f"Point({self.x}, {self.y})"

    def __add__(self, other):
        if isinstance(other, self.__class__):
            x = self.x + other.x
            y = self.y + other.y
            return self.__class__(x, y)
        if isinstance(other, Vector):
            return self + other.to_point()
        raise "IDKWTF"

    def __mul__(self, other):
        if isinstance(other, int):
            return self.__class__(self.x * other, self.y * other)
        if isinstance(other, self.__class__):
            return self.__class__(self.x * other.x, self.y * other.y)
        raise "IDKWTF"

    def __eq__(self, other):
        return self.x == other.x and self.y == other.y

    def __hash__(self):
        return hash((self.x, self.y))

class Path:
    def __init__(self, path_string = None):
        self.vectors = []
        if isinstance(path_string, str):
            for vector_string in path_string.split(","):
                self.extend(vector_string)

    def extend(self, vector_or_string):
        v = Vector(vector_or_string)
        self.vectors.append(v)

    def points(self):
        pts = [ Point(0, 0) ]
        for v in self.vectors:
            tail = pts[-1]
            pts += tail.points_along(v)[1:]
        return pts

    def turning_points(self):
        pts = [ Point(0, 0) ]
        for v in self.vectors:
            pts.append( pts[-1] + v )
        return pts

    def steps_to(self, point):
        return self.points().index(point)

    def intersections(self, other):
        ps1 = set( self.points() )
        ps2 = set( other.points() )
        ints = ps1 & ps2
        return [ x for x in self.points() if x in ints and x != Point(0, 0) ]

    def __repr__(self):
        tps = map(str, self.turning_points())
        return " --> ".join(tps)
