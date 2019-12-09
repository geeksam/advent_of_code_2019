require_relative 'intcode_computer/intcode'

class IntcodeComputer
  def self.execute_listing(listing, input: [], output: [])
    computer = from_listing(listing)
    computer.execute(input, output)
    computer.listing
  end

  def self.from_listing(listing)
    stack = listing.split(",").map(&:to_i)
    new(stack)
  end

  attr_reader :stack
  def initialize(stack)
    @stack = stack
  end

  def listing
    stack.join(",")
  end

  def execute(input = [], output = [])
    self.pc = 0
    catch :halt do
      loop do
        self.pc = Intcode.execute(stack, pc, input, output)
      end
    end
  end

  protected
  attr_accessor :pc

end
