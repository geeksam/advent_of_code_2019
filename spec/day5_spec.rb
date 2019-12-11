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

  specify "example program including parameter modes" do
    expect( IntcodeComputer.execute_listing("1002,4,3,4,33") ).to eq( "1002,4,3,4,99" )
  end

  specify "example program using negative values" do
    expect( IntcodeComputer.execute_listing("1101,100,-1,4,0") ).to eq( "1101,100,-1,4,99" )
  end

  let(:listing) { read_fixture_file("day5_listing.txt") }
  specify "day five part one" do
    io = { input: [1], output: [] }
    IntcodeComputer.execute_listing(listing, **io)
    expect( io[:output].last ).to eq( 13087969 )
  end

  specify "various param counts" do
    computer = double("IntcodeComputer")
    ic = IntcodeComputer::Halt.new(computer)     ; expect( ic.param_count ).to eq( 0 ) ; expect( ic.instruction_length ).to eq( 1 )
    ic = IntcodeComputer::Add.new(computer)      ; expect( ic.param_count ).to eq( 3 ) ; expect( ic.instruction_length ).to eq( 4 )
    ic = IntcodeComputer::Multiply.new(computer) ; expect( ic.param_count ).to eq( 3 ) ; expect( ic.instruction_length ).to eq( 4 )
    ic = IntcodeComputer::Input.new(computer)    ; expect( ic.param_count ).to eq( 1 ) ; expect( ic.instruction_length ).to eq( 2 )
    ic = IntcodeComputer::Output.new(computer)   ; expect( ic.param_count ).to eq( 1 ) ; expect( ic.instruction_length ).to eq( 2 )
  end

  specify "example programs that compare input to 8" do
    foo = "3,9,8,9,10,9,4,9,99,-1,8"
    io = { input: [42], output: [] }
    IntcodeComputer.execute_listing(foo, **io)
    expect( io[:output] ).to eq( [0] )
    io = { input: [8], output: [] }
    IntcodeComputer.execute_listing(foo, **io)
    expect( io[:output] ).to eq( [1] )

    foo = "3,9,7,9,10,9,4,9,99,-1,8"
    io = { input: [7], output: [] }
    IntcodeComputer.execute_listing(foo, **io)
    expect( io[:output] ).to eq( [1] )
    io = { input: [8], output: [] }
    IntcodeComputer.execute_listing(foo, **io)
    expect( io[:output] ).to eq( [0] )
    io = { input: [8], output: [] }
    IntcodeComputer.execute_listing(foo, **io)
    expect( io[:output] ).to eq( [0] )

    foo = "3,3,1108,-1,8,3,4,3,99"
    io = { input: [42], output: [] }
    IntcodeComputer.execute_listing(foo, **io)
    expect( io[:output] ).to eq( [0] )
    io = { input: [8], output: [] }
    IntcodeComputer.execute_listing(foo, **io)
    expect( io[:output] ).to eq( [1] )

    foo = "3,3,1107,-1,8,3,4,3,99"
    io = { input: [7], output: [] }
    IntcodeComputer.execute_listing(foo, **io)
    expect( io[:output] ).to eq( [1] )
    io = { input: [8], output: [] }
    IntcodeComputer.execute_listing(foo, **io)
    expect( io[:output] ).to eq( [0] )
    io = { input: [8], output: [] }
    IntcodeComputer.execute_listing(foo, **io)
    expect( io[:output] ).to eq( [0] )
  end

  specify "example programs that output 0 if input is 0, 1 otherwise" do
    foo = "3,12,6,12,15,1,13,14,13,4,13,99,-1,0,1,9"

    io = { input: [42], output: [] }
    IntcodeComputer.execute_listing(foo, **io)
    expect( io[:output] ).to eq( [1] )

    io = { input: [0], output: [] }
    IntcodeComputer.execute_listing(foo, **io)
    expect( io[:output] ).to eq( [0] )

    foo = "3,3,1105,-1,9,1101,0,0,12,4,12,99,1"

    io = { input: [42], output: [] }
    IntcodeComputer.execute_listing(foo, **io)
    expect( io[:output] ).to eq( [1] )

    io = { input: [0], output: [] }
    IntcodeComputer.execute_listing(foo, **io)
    expect( io[:output] ).to eq( [0] )
  end

  specify "a larger example program" do
    foo = "3,21,1008,21,8,20,1005,20,22,107,8,21,20,1006,20,31,1106,0,36,98,0,0,1002,21,125,20,4,20,1105,1,46,104,999,1105,1,46,1101,1000,1,20,4,20,1105,1,46,98,99"

    io = { input: [7], output: [] }
    IntcodeComputer.execute_listing(foo, **io)
    expect( io[:output] ).to eq( [999] )

    io = { input: [8], output: [] }
    IntcodeComputer.execute_listing(foo, **io)
    expect( io[:output] ).to eq( [1000] )

    io = { input: [9], output: [] }
    IntcodeComputer.execute_listing(foo, **io)
    expect( io[:output] ).to eq( [1001] )
  end

  specify "day five part two" do
    io = { input: [5], output: [] }
    IntcodeComputer.execute_listing(listing, **io)
    expect( io[:output].last ).to eq( 14110739 )
  end

end
