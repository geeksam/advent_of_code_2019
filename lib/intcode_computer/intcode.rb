class IntcodeComputer
  class Intcode
    def self.execute(stack, pc, input, output)
      intcode = stack[pc]
      klass =
        case intcode
        when nil ; fail "WTF?!"
        when 1   ; Add
        when 2   ; Multiply
        when 3   ; Input
        when 4   ; Output
        when 99  ; Halt
        else     ; self
        end
      klass.new(intcode, stack, pc, input, output).execute
    end

    attr_reader :intcode, :stack, :pc, :input, :output
    def initialize(intcode, stack, pc, input, output)
      @intcode        = intcode
      @stack, @pc     = stack, pc
      @input, @output = input, output
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
