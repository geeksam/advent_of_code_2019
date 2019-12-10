class IntcodeComputer
  class Intcode
    def self.execute(stack, pc, input, output)
      intcode = stack[pc]
      klass = SUBCLASSES.detect { |e| e.accepts?(intcode) }
      if klass.nil?
        fail ArgumentError, "UNrecognized int code #{intcode} at position #{pc} of stack #{stack.join(",")}"
      end
      klass.new(intcode, stack, pc, input, output).execute
    end

    SUBCLASSES = []

    def self.inherited(subclass)
      SUBCLASSES << subclass
      super
    end

    def self.code            ; @code            ; end
    def self.code=(n)        ; @code = n        ; end
    def self.param_count     ; @param_count     ; end
    def self.param_count=(n) ; @param_count = n ; end

    def self.accepts?(intcode)
      intcode % 100 == code
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

    # A param is always "a position on the stack frame relative to the program counter"
    def param(n)
      fail IndexError, "can't get param #{n} of #{self.class.param_count}" if n > self.class.param_count
      stack[ pc + n ]
    end

    # A value is some interpretation of a param, depending on the intcode's "mode" (position or immediate)
    def value(n)
      cell = param(n)
      case mode(n)
      when :position  ; fail "Y U NIL, #{n}? #{stack[pc, self.class.param_count+1].inspect}" if stack[cell].nil?; stack[ cell ]
      when :immediate ; cell
      else            ; fail "IDKWTFLOL"
      end
    end

    def inspect
      s = "<#{self.class}"
      self.class.param_count.times do |i|
        s << " (P#{i+1} ="
        s << " #{param(i+1)} -> value #{value(i+1)})"
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

    def exec
      fail "Subclass responsibility!"
    end
  end
end
