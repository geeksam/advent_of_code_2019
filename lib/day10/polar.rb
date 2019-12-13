class Polar
  attr_reader :theta, :r
  def initialize(theta, r)
    @theta = theta.round(3)
    @r     = r    .round(3)
  end

  def ==(other)
    [ theta, r ] == [ other.theta, other.r ]
  end
  alias :eql? :==

  def hash
    [ theta, r ].hash
  end

  def <=>(other)
    [ theta, r ] <=> [ other.theta, other.r ]
  end

  def inspect
    "(Θ #{theta}, r #{r})"
  end
end

def Polar(theta, r)
  Polar.new(theta, r)
end
