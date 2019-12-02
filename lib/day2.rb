module ShipComputer
  extend self

  def execute_listing(listing)
    stack = listing.split(",").map(&:to_i)
    execute_stack stack
    stack.join(",")
  end

  def execute_stack(stack)
    pc = 0

    loop do
      case stack[pc]
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
