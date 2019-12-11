require 'forwardable'

class IntcodeComputer
  class Intcode
    def self.for(computer)
      klass = SUBCLASSES.detect { |e| e.accepts?(computer.intcode) }
      if klass.nil?
        fail ArgumentError, "Unrecognized int code #{computer.intcode} at position #{computer.pc} of stack #{computer.stack.join(",")}"
      end
      klass.new(computer)
    end

    SUBCLASSES = []

    def self.inherited(subclass)
      SUBCLASSES << subclass
      super
    end

    def self.code     ; @code     ; end
    def self.code=(n) ; @code = n ; end

    def self.param_count     ; @param_count           ; end
    def self.param_count=(n) ; @param_count = n       ; end
    def      param_count     ; self.class.param_count ; end

    def self.accepts?(intcode)
      intcode % 100 == code
    end

    extend Forwardable
    attr_reader :computer
    def_delegators :computer, *%i[ intcode stack pc input output ]
    def initialize(computer)
      @computer = computer
    end

    def execute
      fail "Subclass responsibility!"
    end

    def instruction_length
      1 + param_count
    end

    # A param is always "a position on the stack frame relative to the program counter"
    def param(n)
      fail IndexError, "can't get param #{n} of #{param_count}" if n > param_count
      stack[ pc + n ]
    end

    # A value is some interpretation of a param, depending on the intcode's "mode" (position or immediate)
    def value(n)
      cell = param(n)
      case mode(n)
      when :position  ; fail "Y U NIL, p#{n}? #{stack[pc, param_count+1].inspect}" if stack[cell].nil?; stack[ cell ]
      when :immediate ; cell
      else            ; fail "IDKWTFLOL"
      end
    end

    def inspect
      s = "<#{self.class}"
      param_count.times do |i|
        s << " #{debug_param(i + 1)}"
      end
      s << ">"
      s
    end

    private

    def mode(n)
      s = ("%05d" % intcode)[0..2].reverse
      case s[n-1]
      when "0" ; :position
      when "1" ; :immediate
      else ; fail "IDKWTFLOL"
      end
    end

    def consume_input
      input.shift.tap do |value|
        debug "consuming input: #{value}"
      end
    end

    def write_output(value)
      debug "outputting #{value}"
      output << value
    end

    def set_value(at:, to:)
      debug "setting position #{at} (currently #{stack[at]}) to #{to}"
      stack[at] = to
    end

    def next_instruction
      debug "next instruction"
      computer.pc += instruction_length
    end

    def jump_to(address)
      debug "jumping to #{address}"
      computer.pc = address
    end

    def debug(msg)
      return unless $debug
      prefix = self.class.name.split("::").last
      puts prefix + ": " + msg
    end

    def debug_param(n)
      s = "(p#{n}: "
      case mode(n)
      when :position
        s << "*#{param(n)} -> #{value(n)}"
      when :immediate
        s << "#{param(n)}"
      end
      s << ")"
      s
    end
  end
end

