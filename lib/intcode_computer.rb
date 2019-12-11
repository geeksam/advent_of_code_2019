require_relative 'intcode_computer/stack'
require_relative 'intcode_computer/intcode'
require_relative 'intcode_computer/intcodes'

class IntcodeComputer
  def self.execute_listing(listing, input: [], output: [])
    stack = stack_from_listing(listing)
    computer = new(stack, input, output)
    computer.execute
    computer.listing
  end

  def self.stack_from_listing(listing)
    listing.split(",").map(&:to_i)
  end

  def self.from_listing(listing)
    new(stack_from_listing(listing))
  end

  attr_reader :stack
  attr_accessor :pc, :input, :output, :relative_base
  def initialize(stack, input = [], output = [])
    @pc, @relative_base = 0, 0
    @input, @output = input, output
    @stack = IntcodeComputer::Stack.new(stack)
  end

  def listing
    stack.join(",")
  end

  def execute
    catch :halt do
      puts "", "-" * 5 if $debug
      loop do
        intcode = Intcode.for(self)
        debug_state(intcode)
        intcode.execute
      end
    end
  end

  def intcode
    stack[pc]
  end

  protected

  def debug_state(intcode)
    return unless $debug
    puts "\nPC: #{pc} (value: #{stack[pc]})\nStack: #{stack.inspect}\n#{intcode.inspect}"
  end

end
