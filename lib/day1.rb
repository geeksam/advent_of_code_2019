module Fuel
  extend self

  def for_mass_simple(m)
    ( m / 3 ).floor - 2
  end

  def for_mass(m)
    total = 0
    loop do
      moar_fuel = for_mass_simple(m)
      break if moar_fuel < 1
      total += moar_fuel
      m = moar_fuel
    end

    total
  end
end
