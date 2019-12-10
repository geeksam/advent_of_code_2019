require_relative 'intcode_computer'

class Amplifier
  attr_reader :listing
  def initialize(listing)
    @listing = listing
  end

  def run(phase_setting, input_signal)
    io = { input: [ phase_setting, input_signal ], output: [] }
    IntcodeComputer.execute_listing(listing, **io)
    return io[:output].first
  end
end

class AmplifierSet
  attr_reader :listing
  def initialize(listing)
    @listing = listing
  end

  def thruster_setting(phase_settings)
    input_signal = 0
    phase_settings.each do |phase_setting|
      input_signal = Amplifier.new(listing).run(phase_setting, input_signal)
    end
    input_signal
  end

  def max_thruster_setting
    outputs = (0..4).to_a.permutation.map { |phases|
      [ phases, thruster_setting(phases) ]
    }
    return *outputs.sort_by(&:last).last
  end
end
