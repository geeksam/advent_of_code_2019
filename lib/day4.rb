class PasswordChecker
  def self.ok?(candidate)
    new(candidate).ok?
  end

  attr_reader :pw, :digits
  def initialize(pw)
    @pw     = pw.to_s
    @digits = @pw.split("").map(&:to_i)
  end

  def ok?
    return false unless has_double?
    return false if decreases?
    true
  end

  private

  def has_double?
    runs.include?(2)
  end

  def decreases?
    digits.each_cons(2) do |a, b|
      return true if a > b
    end
    false
  end

  # wow, this is gross
  def runs
    @_runs ||=
      begin
        [].tap do |runs|
          prev = nil
          digits.each_cons(2) do |a, b|
            if a == b
              if prev.nil?
                runs << 2
                prev = a
              else
                runs[-1] += 1
              end
            else
              prev = nil
            end
          end
        end
      end
  end
end
