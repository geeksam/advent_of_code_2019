class IntcodeComputer
  class Halt < Intcode
    def exec
      throw :halt
    end
  end

  class BinaryWithDestination < Intcode
    private
    def lft ; stack[pc + 1] ; end
    def rgt ; stack[pc + 2] ; end
    def dst ; stack[pc + 3] ; end
  end

  class Add < BinaryWithDestination
    def exec
      a, b = stack[lft], stack[rgt]
      stack[dst] = a + b
    end
  end

  class Multiply < BinaryWithDestination
    def exec
      a, b = stack[lft], stack[rgt]
      stack[dst] = a * b
    end
  end

  class Input < Intcode
    def exec
      ptr = stack[pc+1]
      stack[ptr] = input.shift
    end

    def instruction_length
      2
    end
  end

  class Output < Intcode
    def exec
      ptr = stack[pc+1]
      output << stack[ptr]
    end

    def instruction_length
      2
    end
  end
end

