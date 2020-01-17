from math import floor

def for_mass_simple(m):
    return floor( m / 3 ) - 2

def for_mass(m):
    total = 0
    while True:
        moar_fuel = for_mass_simple(m)
        if moar_fuel < 1:
            break
        total += moar_fuel
        m = moar_fuel

    return total
