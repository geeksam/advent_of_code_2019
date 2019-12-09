require_relative 'intcode_computer/intcode'

class IntcodeComputer
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

  def execute
    self.pc = 0
    catch :halt do
      loop do
        int = stack[pc]
        self.pc = Intcode.execute(int, stack, pc)
      end
    end
  end

  protected
  attr_accessor :pc

end
