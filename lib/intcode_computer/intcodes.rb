class IntcodeComputer
  class Add < Intcode
    self.code = 1
    self.param_count = 3

    def execute
      debug "add #{debug_param(1)} and #{debug_param(2)} and store result to position #{param(3)}"
      stack[param(3)] = value(1) + value(2)
      return pc + instruction_length
    end
  end

  class Multiply < Intcode
    self.code = 2
    self.param_count = 3

    def execute
      debug "multiply #{debug_param(1)} and #{debug_param(2)} and store result to position #{param(3)}"
      stack[param(3)] = value(1) * value(2)
      return pc + instruction_length
    end
  end

  class Input < Intcode
    self.code = 3
    self.param_count = 1

    def execute
      debug "store input (#{input.first.inspect}) to position #{param(1)}"
      stack[param(1)] = input.shift
      return pc + instruction_length
    end
  end

  class Output < Intcode
    self.code = 4
    self.param_count = 1

    def execute
      debug "outputting #{debug_param(1)}"
      output << value(1)
      return pc + instruction_length
    end
  end

  class JumpIfTrue < Intcode
    self.code = 5
    self.param_count = 2

    def execute
      debug "Checking if #{debug_param(1)} is NON-ZERO"
      if value(1).zero?
        debug "continuing normally"
        return pc + instruction_length
      else
        debug "jumping to #{debug_param(2)}"
        return value(2)
      end
    end
  end

  class JumpIfFalse < Intcode
    self.code = 6
    self.param_count = 2

    def execute
      debug "Checking if #{debug_param(1)} is ZERO"
      if value(1).zero?
        debug "jumping to #{debug_param(2)}"
        return value(2)
      else
        debug "continuing normally"
        return pc + instruction_length
      end
    end
  end

  class LessThan < Intcode
    self.code = 7
    self.param_count = 3

    def execute
      debug "Checking if #{debug_param(1)} < #{debug_param(2)}"
      result = value(1) < value(2) ? 1 : 0
      debug "storing #{result} to position ##{param(3)}"
      stack[param(3)] = result
      return pc + instruction_length
    end
  end

  class Equal < Intcode
    self.code = 8
    self.param_count = 3

    def execute
      debug "Checking if #{debug_param(1)} < #{debug_param(2)}"
      result = value(1) == value(2) ? 1 : 0
      debug "storing #{result} to position ##{param(3)}"
      stack[param(3)] = result
      return pc + instruction_length
    end
  end

  class Halt < Intcode
    self.code = 99
    self.param_count = 0

    def execute
      debug "halting"
      throw :halt
    end
  end

end
