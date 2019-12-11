class IntcodeComputer
  class Add < Intcode
    self.code = 1
    self.param_count = 3

    def execute
      debug "add #{debug_param(1)} and #{debug_param(2)}"
      result = value(1) + value(2)
      case mode(3)
      when :position  ; set_value at: param(3), to: result
      when :immediate ; fail "can't write in immediate mode (see day 5)"
      when :relative  ; set_value at: relative_base + param(3), to: result
      end
      next_instruction
    end
  end

  class Multiply < Intcode
    self.code = 2
    self.param_count = 3

    def execute
      debug "multiply #{debug_param(1)} and #{debug_param(2)}"
      result = value(1) * value(2)
      case mode(3)
      when :position  ; set_value at: param(3), to: result
      when :immediate ; fail "can't write in immediate mode (see day 5)"
      when :relative  ; set_value at: relative_base + param(3), to: result
      end
      next_instruction
    end
  end

  class Input < Intcode
    self.code = 3
    self.param_count = 1

    def execute
      case mode(1)
      when :position  ; set_value at: param(1), to: consume_input
      when :immediate ; fail "can't write in immediate mode (see day 5)"
      when :relative  ; set_value at: relative_base + param(1), to: consume_input
      end
      next_instruction
    end
  end

  class Output < Intcode
    self.code = 4
    self.param_count = 1

    def execute
      write_output value(1)
      next_instruction
    end
  end

  class JumpIfTrue < Intcode
    self.code = 5
    self.param_count = 2

    def execute
      debug "checking if #{debug_param(1)} is NON-ZERO"
      if value(1).zero?
        next_instruction
      else
        jump_to value(2)
      end
    end
  end

  class JumpIfFalse < Intcode
    self.code = 6
    self.param_count = 2

    def execute
      debug "checking if #{debug_param(1)} is ZERO"
      if value(1).zero?
        jump_to value(2)
      else
        next_instruction
      end
    end
  end

  class LessThan < Intcode
    self.code = 7
    self.param_count = 3

    def execute
      debug "checking if #{debug_param(1)} < #{debug_param(2)}"
      result = value(1) < value(2) ? 1 : 0
      case mode(3)
      when :position  ; set_value at: param(3), to: result
      when :immediate ; fail "can't write in immediate mode (see day 5)"
      when :relative  ; set_value at: relative_base + param(3), to: result
      end
      next_instruction
    end
  end

  class Equal < Intcode
    self.code = 8
    self.param_count = 3

    def execute
      debug "checking if #{debug_param(1)} < #{debug_param(2)}"
      result = value(1) == value(2) ? 1 : 0
      case mode(3)
      when :position  ; set_value at: param(3), to: result
      when :immediate ; fail "can't write in immediate mode (see day 5)"
      when :relative  ; set_value at: relative_base + param(3), to: result
      end
      next_instruction
    end
  end

  class AdjustRelativeBase < Intcode
    self.code = 9
    self.param_count = 1

    def execute
      adjust_relative_base value(1)
      next_instruction
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
