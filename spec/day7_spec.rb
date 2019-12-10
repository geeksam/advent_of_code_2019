require 'spec_helper'
require LIB.join("day7")

RSpec.describe "day seven" do
  describe "five amps" do
    let(:listing1) { "3,15,3,16,1002,16,10,16,1,16,15,15,4,15,99,0,0" }
    let(:listing2) { "3,23,3,24,1002,24,10,24,1002,23,-1,23,101,5,23,23,1,24,23,23,4,23,99,0,0" }
    let(:listing3) { "3,31,3,32,1002,32,10,32,1001,31,-2,31,1007,31,0,33,1002,33,7,33,1,33,31,31,1,32,31,31,4,31,99,0,0,0" }
    let(:puzzle_input) { File.read( Pathname.new(File.dirname(__FILE__)).join("day7-input.txt") ) }

    specify "first example" do
      amps = AmplifierSet.new(listing1)
      output = amps.thruster_setting( [ 4, 3, 2, 1, 0 ] )
      expect( output ).to eq( 43210 )
    end

    specify "second example" do
      amps = AmplifierSet.new(listing2)
      output = amps.thruster_setting( [ 0, 1, 2, 3, 4 ] )
      expect( output ).to eq( 54321 )
    end

    specify "third example" do
      amps = AmplifierSet.new(listing3)
      output = amps.thruster_setting( [ 1, 0, 4, 3, 2 ] )
      expect( output ).to eq( 65210 )
    end

    specify "brute-forcing the first example" do
      amps = AmplifierSet.new(listing1)
      phases, output = amps.max_thruster_setting
      expect( phases ).to eq( [ 4, 3, 2, 1, 0 ] )
      expect( output ).to eq( 43210 )
    end

    specify "brute-forcing the second example" do
      amps = AmplifierSet.new(listing2)
      phases, output = amps.max_thruster_setting
      expect( phases ).to eq( [ 0, 1, 2, 3, 4 ] )
      expect( output ).to eq( 54321 )
    end

    specify "brute-forcing the third example" do
      amps = AmplifierSet.new(listing3)
      phases, output = amps.max_thruster_setting
      expect( phases ).to eq( [ 1, 0, 4, 3, 2 ] )
      expect( output ).to eq( 65210 )
    end

    specify "part one" do
      amps = AmplifierSet.new(puzzle_input)
      phases, output = amps.max_thruster_setting
      expect( phases ).to eq( [ 0, 4, 1, 3, 2 ] )
      expect( output ).to eq( 117312 )
    end
  end
end
