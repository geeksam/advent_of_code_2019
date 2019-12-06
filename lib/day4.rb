class PasswordChecker
  def self.ok?(candidate)
    new(candidate).ok?
  end

  attr_reader :pw
  def initialize(pw)
    @pw = pw.to_s
  end

  def ok?
    return false unless has_double?
    return false if decreases?
    true
  end

  private

  def has_double?
    !!( pw =~ /(\d)\1/ )
  end

  def decreases?
    digits.each_cons(2) do |a, b|
      return true if a > b
    end
    false
  end

  def digits
    @_digits ||= pw.split("").map(&:to_i)
  end
end

# range = 273025-767253
