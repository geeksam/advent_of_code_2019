module ShipComputer
  extend self

  def stack_from_listing(listing)
    listing.split(",").map(&:to_i)
  end

  def execute_listing(listing)
    stack = stack_from_listing(listing)
    execute_stack stack
    stack.join(",")
  end

  def execute_stack(stack)
    pc = 0

    loop do
      op, lft, rgt, dst = *stack[pc, 4]
      case op
      when 99 ; break
      when 1  ; stack[dst] = stack[lft] + stack[rgt]
      when 2  ; stack[dst] = stack[lft] * stack[rgt]
      end
      pc += 4
    end
  end
end
