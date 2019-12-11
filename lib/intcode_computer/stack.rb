require 'delegate'

class IntcodeComputer
  class Stack < DelegateClass(Array)
    # Always return zero when asked for a value that's out of bounds
    def [](index)
      super || 0
    end
  end
end
