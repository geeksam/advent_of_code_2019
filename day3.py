import math
import re

class Vector:
    def __init__(self, dir, len):
        self.dir, self.len = dir, len

    @classmethod
    def build(self, vector_or_string):
        if isinstance(vector_or_string, str):
            m = re.match(r"([URDL])(\d+)", vector_or_string)
            dir = m.group(1)
            len = int(m.group(2))
            return self(dir, len)
        if isinstance(vector_or_string, self):
            return vector_or_string
        else:
            raise "IDKWTF"

    def unit(self):
        if self.dir == "U": return Point(  0,  1 )
        if self.dir == "R": return Point(  1,  0 )
        if self.dir == "D": return Point(  0, -1 )
        if self.dir == "L": return Point( -1,  0 )
        else:           raise "IDKWTF"

    def to_point(self):
        return self.unit() * self.len

    def __eq__(self, other):
        return self.dir == other.dir and self.len == other.len

    def __repr__(self):
        return f"Vector('{self.dir}{self.len}')"

class Point:
    def __init__(self, x, y):
        self.x, self.y = x, y

    def manhattan_distance(self):
        return math.fabs(self.x) + math.fabs(self.y)

    def __repr__(self):
        return f"Point({self.x}, {self.y})"

    def __add__(self, other):
        x = self.x + other.x
        y = self.y + other.y
        return self.__class__(x, y)

    def __mul__(self, other):
        if isinstance(other, int):
            return self.__class__(self.x * other, self.y * other)
        if isinstance(other, self.__class__):
            return self.__class__(self.x * other.x, self.y * other.y)
        else:
            raise "IDKWTF"

    def __eq__(self, other):
        return self.x == other.x and self.y == other.y

    def points_along(self, vector_string):
        v = Vector.build(vector_string)
        points = []
        for i in range(0, v.len+1):
            delta = v.unit() * i
            p = self + delta
            points.append(p)
        return points

class Path:
    def __init__(self):
        self.vectors = []

    def extend(self, vector_or_string):
        v = Vector.build(vector_or_string)
        self.vectors.append(v)

    def points(self):
        list = [ Point(0, 0) ]
        for v in self.vectors:
            tail = list[-1]
            list += tail.points_along(v)[1:]
        return list
