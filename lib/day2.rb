require_relative 'intcode_computer'

module ShipComputer
  extend self

  def execute_listing(listing)
    computer = IntcodeComputer.from_listing(listing)
    computer.execute
    computer.listing
  end

  def execute_stack(stack)
    computer = IntcodeComputer.from_stack(stack)
    computer.execute
  end
end
