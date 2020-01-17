import math
import re

class Point:
    def __init__(self, x, y):
        self.x, self.y = x, y

    @classmethod
    def from_vector(self, vector_string):
        p = re.compile('([URDL])([0-9]+)')
        m = p.match(vector_string)
        if m:
            direction = self.from_direction(m.group(1))
            magnitude = int(m.group(2))
            return direction * magnitude
        else:
            return self(0, 0)

    @classmethod
    def from_direction(self, direction):
        if   "U" == direction: return self(  0,  1 )
        elif "D" == direction: return self(  0, -1 )
        elif "L" == direction: return self( -1,  0 )
        elif "R" == direction: return self(  1,  0 )
        else:                  return self(  0,  0 )

    def __repr__(self):
        return f"Point({self.x}, {self.y})"

    def __eq__(self, other):
        return self.x == other.x and self.y == other.y

    def __add__(self, other):
        x = self.x + other.x
        y = self.y + other.y
        return self.__class__(x, y)

    def __mul__(self, other):
        if isinstance(other, self.__class__):
            x = self.x * other.x
            y = self.y * other.y
        else:
            x = self.x * other
            y = self.y * other
        return self.__class__(x, y)

    def manhattan_distance(self):
        return math.fabs(self.x) + math.fabs(self.y)

    def points_along(self, vector_string):
        pass

class Path:
    def __init__(self):
        self.junctions = []
        self.points = [ Point(0, 0) ]

    def extend(self, vector_string):
        # p1 = self.junctions.last or Point(0, 0)
        p2 = Point.from_vector(vector_string)
        self.junctions.append(p2)


