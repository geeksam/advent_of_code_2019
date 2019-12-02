module Fuel
  extend self

  def for_mass(m)
    ( m / 3 ).floor - 2
  end

  def for_mass_including_fuel(m)
    total = 0
    loop do
      moar_fuel = for_mass(m)
      break if moar_fuel < 1
      total += moar_fuel
      m = moar_fuel
    end

    total
  end
end
