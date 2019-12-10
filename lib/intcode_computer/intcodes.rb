class IntcodeComputer
  class Halt < Intcode
    self.code = 99
    self.param_count = 0

    def exec
      throw :halt
    end
  end

  class Add < Intcode
    self.code = 1
    self.param_count = 3

    def exec
      stack[param(3)] = value(1) + value(2)
    end
  end

  class Multiply < Intcode
    self.code = 2
    self.param_count = 3

    def exec
      stack[param(3)] = value(1) * value(2)
    end
  end

  class Input < Intcode
    self.code = 3
    self.param_count = 1

    def exec
      stack[param(1)] = input.shift
    end
  end

  class Output < Intcode
    self.code = 4
    self.param_count = 1

    def exec
      output << value(1)
    end
  end
end

