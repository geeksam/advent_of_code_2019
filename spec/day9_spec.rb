require 'spec_helper'
require LIB.join("intcode_computer")

RSpec.describe "IntcodeComputer, day nine" do
  let(:listing1) { "109,1,204,-1,1001,100,1,100,1008,100,16,101,1006,101,0,99" }
  let(:listing2) { "1102,34915192,34915192,7,4,7,99,0" }
  let(:listing3) { "104,1125899906842624,99" }

  specify "first example" do
    io = { input: [], output: [] }
    IntcodeComputer.execute_listing(listing1, **io)
    expect( io[:output] ).to eq( IntcodeComputer.stack_from_listing(listing1) )
  end

  specify "second example" do
    io = { input: [], output: [] }
    IntcodeComputer.execute_listing(listing2, **io)
    expect( io[:output] ).to eq( [1_219_070_632_396_864] )
  end

  specify "third example" do
    io = { input: [], output: [] }
    IntcodeComputer.execute_listing(listing3, **io)
    expect( io[:output] ).to eq( [1_125_899_906_842_624] )
  end

  # specify "part one" do
  #   listing = read_fixture_file("day9-input.txt")
  #   io = { input: [1], output: [] }
  #   IntcodeComputer.execute_listing(listing, **io)
  #   expect( io[:output] ).to eq( [3_100_786_347] )
  # end
  #
  # specify "part two" do
  #   listing = read_fixture_file("day9-input.txt")
  #   io = { input: [2], output: [] }
  #   IntcodeComputer.execute_listing(listing, **io)
  #   expect( io[:output] ).to eq( [87023] )
  # end
end
