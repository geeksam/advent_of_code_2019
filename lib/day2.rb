require_relative 'intcode_computer'

module ShipComputer
  extend self

  def execute_listing(listing)
    computer = IntcodeComputer.from_listing(listing)
    computer.execute
    computer.listing
  end
end
