require 'spec_helper'
require LIB.join("intcode_computer")

RSpec.describe "IntcodeComputer, day five" do
  specify "opcode 3 takes a single integer as input and saves it to the position given by its only parameter" do
    expect( IntcodeComputer.execute_listing("3,1,99", input: [ 42 ]) ).to eq( "3,42,99" )
  end

  specify "opcode 4 outputs the value of its only parameter" do
    out = []
    IntcodeComputer.execute_listing("4,42,99", output: out)
    expect( out ).to eq( [42] )
  end
end
