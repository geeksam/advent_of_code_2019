class IntcodeComputer
  class Intcode
    def self.execute(stack, pc)
      intcode = stack[pc]
      klass =
        case intcode
        when nil ; fail "WTF?!"
        when 1   ; Add
        when 2   ; Multiply
        when 99  ; Halt
        else     ; self
        end
      klass.new(intcode, stack, pc).execute
    end

    attr_reader :intcode, :stack, :pc
    def initialize(intcode, stack, pc)
      @intcode    = intcode
      @stack, @pc = stack, pc
    end

    def execute
      exec
      return pc + instruction_length
    end

    def instruction_length
      4
    end

    private

    def exec
      fail "Subclass responsibility!"
    end
  end



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
end
