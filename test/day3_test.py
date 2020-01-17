from ..day3 import *

class TestPoint:
    def test_construction(self):
        p = Point(0, 1)
        assert 0 == p.x
        assert 1 == p.y

    def test_points_can_be_added(self):
        p1 = Point(1, 1)
        p2 = Point(2, 3)
        assert p1 + p2 == Point(3, 4)

    def test_points_can_be_scaled_by_a_scalar(self):
        p1 = Point(1, 2)
        assert Point(3, 6) == p1 * 3

    def test_points_can_be_scaled_by_a_point(self):
        p1 = Point(1, 2)
        p2 = Point(3, 2)
        assert Point(3, 4) == p1 * p2

    def test_manhattan_distance(self):
        p1 = Point(2, 3)
        assert 5 == p1.manhattan_distance()

    def test_construction_from_direction(self):
        assert Point( 0,  1) == Point.from_direction("U")
        assert Point( 1,  0) == Point.from_direction("R")
        assert Point( 0, -1) == Point.from_direction("D")
        assert Point(-1,  0) == Point.from_direction("L")

    def test_construction_from_vector(self):
        assert Point( 0,  1) == Point.from_vector("U1")
        assert Point( 1,  0) == Point.from_vector("R1")
        assert Point( 0, -1) == Point.from_vector("D1")
        assert Point(-1,  0) == Point.from_vector("L1")

        assert Point( 0,  1) == Point.from_vector("U1")
        assert Point( 2,  0) == Point.from_vector("R2")
        assert Point( 0, -3) == Point.from_vector("D3")
        assert Point(-4,  0) == Point.from_vector("L4")

    def test_points_along(self):
        p1 = Point(1, 1)
        assert p1.points_along("R2") == [
            Point(1, 1),
            Point(2, 1),
            Point(3, 1),
        ]

class TestPath:
    def test_empty_path_has_no_junctions(self):
        assert Path().junctions == []

    def test_empty_path_points_contains_the_origin(self):
        assert Path().points == [ Point(0, 0) ]

    def test_path_can_add_junctions(self):
        path = Path()
        path.extend("R3")
        assert path.junctions == [ Point(3, 0) ]

    # def test_path_with_junctions_knows_all_points_on_path(self):
    #     path = Path()
    #     path.extend("R3")
    #     assert path.points == [
    #         Point(0, 0)
    #     ]
    #
