require_relative 'intcode_computer'

module ShipComputer
  extend self

  def execute_listing(listing)
    computer = IntcodeComputer.from_listing(listing)
    computer.execute
    computer.listing
  end

  def execute_stack(stack)
    pc = 0

    loop do
      case stack[pc]
      when nil
        fail "WTF?!"
      when 99
        break
      when 1
        lft, rgt, dst = *stack[pc+1, 3]
        a, b = stack[lft], stack[rgt]
        stack[dst] = a + b
      when 2
        lft, rgt, dst = *stack[pc+1, 3]
        a, b = stack[lft], stack[rgt]
        stack[dst] = a * b
      end
      pc += 4
    end
  end
end
