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
end
