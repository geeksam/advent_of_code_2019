from ..day3 import *

class TestVector:
    def test_construction(self):
        v = Vector("R", 3)
        assert v.dir == "R"
        assert v.len == 3

    def test_for_using_string(self):
        v = Vector.build("R3")
        assert v.dir == "R"
        assert v.len == 3

    def test_for_using_vector(self):
        v1 = Vector.build("R3")
        v2 = Vector.build(v1)
        assert v2.dir == "R"
        assert v2.len == 3

    def test_unit(self):
        assert Point(  0,  1 ) == Vector.build("U2").unit()
        assert Point(  1,  0 ) == Vector.build("R3").unit()
        assert Point(  0, -1 ) == Vector.build("D4").unit()
        assert Point( -1,  0 ) == Vector.build("L5").unit()

    def test_to_point(self):
        assert Point(2, 0) == Vector.build("R2").to_point()

    def test_equality(self):
        v1 = Vector("R", 2)
        v2 = Vector("R", 2)
        assert v1 == v2

class TestPoint:
    def test_construction(self):
        p = Point(2, 3)
        assert 2 == p.x
        assert 3 == p.y

    def test_construction_from_vector(self):
        v = Vector.build("R2")
        assert Point(2, 0) == v.to_point()

    def test_manhattan_distance(self):
        p = Point(2, 3)
        assert 5 == p.manhattan_distance()

    def test_add_and_eql(self):
        p1 = Point(1, 2)
        p2 = Point(3, 4)
        assert Point(4, 6) == (p1 + p2)

    def test_mul_point_and_int(self):
        p = Point(2, 3)
        assert Point(4, 6) == (p * 2)

    def test_mul_two_points(self):
        p1 = Point(1, 2)
        p2 = Point(3, 4)
        assert Point(3, 8) == (p1 * p2)

    def test_points_along(self):
        p = Point(1, 2)
        assert p.points_along("R3") == [
            Point(1, 2),
            Point(2, 2),
            Point(3, 2),
            Point(4, 2),
        ]

class TestPath:
    def test_empty_path_has_no_vectors(self):
        p = Path()
        assert p.vectors == []

    def test_extend(self):
        p = Path()
        p.extend("R2")
        assert p.vectors == [ Vector("R", 2) ]
        p.extend("U1")
        assert p.vectors == [ Vector("R", 2), Vector("U", 1) ]

    def test_points(self):
        p = Path()
        print(p.points())
        assert p.points() == [ Point(0, 0) ]
        p.extend("R2")
        print(p.points())
        assert p.points() == [ Point(0, 0), Point(1, 0), Point(2, 0) ]

