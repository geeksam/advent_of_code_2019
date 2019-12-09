require 'spec_helper'
require LIB.join("intcode_computer")

RSpec.describe "IntcodeComputer, day five" do
  specify "opcode 3 takes a single integer as input and saves it to the position given by its only parameter" do
    expect( IntcodeComputer.execute_listing("3,1,99", input: [ 42 ]) ).to eq( "3,42,99" )
  end

  specify "opcode 4 outputs the value of its only parameter" do
    output = []
    IntcodeComputer.execute_listing("4,2,99", output: output)
    expect( output ).to eq( [99] )
  end

  specify "example program for intcodes 3&4" do
    io = { input: [42], output: [] }
    IntcodeComputer.execute_listing("3,0,4,0,99", **io)
    expect( io ).to eq( { input: [], output: [42] } )
  end
end
