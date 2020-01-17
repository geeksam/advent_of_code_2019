from ..day1 import *

def test_12_simple_mass_requires_2_fuel():
    assert for_mass_simple(12) == 2

def test_14_simple_mass_requires_2_fuel():
    assert for_mass_simple(12) == 2

def test_1969_simple_mass_requires_654_fuel():
    assert for_mass_simple(1969) == 654

def test_100756_simple_mass_requires_33583_fuel():
    assert for_mass_simple(100756) == 33583

MODULE_WEIGHTS = [
    85364,  97431,  135519, 119130, 137800, 85946,  146593, 141318, 103590, 138858, 92329,
    94292,  132098, 144266, 72908,  112896, 87046,  133058, 141121, 74681,  83458,  107417,
    121426, 66005,  106094, 96458,  113316, 142676, 79186,  55480,  147821, 116419, 70532,
    105344, 116797, 126387, 139600, 136382, 121330, 123485, 134336, 141201, 131556, 91346,
    117939, 58373,  129325, 102237, 60644,  96712,  126342, 98939,  66305,  111403, 143257,
    58721,  55552,  139078, 74263,  125989, 90904,  91058,  92130,  53176,  81369,  100856,
    110597, 111141, 129749, 123822, 75321,  80963,  102625, 70161,  107069, 117982, 86443,
    95627,  147801, 149508, 101470, 81879,  133396, 82276,  144803, 67049,  127735, 121064,
    122975, 69435,  139132, 141284, 70798,  117921, 108942, 85662,  75438,  122699, 116654,
    126797,
]

def test_part_one():
    fuels = map(for_mass_simple, MODULE_WEIGHTS)
    total = sum(fuels)
    assert total == 3563458

def test_14_mass_requires_2_fuel():
    assert for_mass(12) == 2

def test_1969_mass_requires_966_fuel():
    assert for_mass(1969) == 966

def test_100756_mass_requires_50346_fuel():
    assert for_mass(100756) == 50346

def test_part_two():
    fuels = map(for_mass, MODULE_WEIGHTS)
    total = sum(fuels)
    assert total == 5342292

