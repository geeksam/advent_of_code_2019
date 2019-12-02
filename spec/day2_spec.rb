require 'spec_helper'
require LIB.join("day2")

RSpec.describe 'a ship computer' do
  specify "1,0,0,0,99 becomes 2,0,0,0,99 (1 + 1 = 2)" do
    expect( ShipComputer.execute_listing("1,0,0,0,99") ).to eq( "2,0,0,0,99" )
  end

  specify "2,3,0,3,99 becomes 2,3,0,6,99 (3 * 2 = 6)" do
    expect( ShipComputer.execute_listing("2,3,0,3,99") ).to eq( "2,3,0,6,99" )
  end

  specify "2,4,4,5,99,0 becomes 2,4,4,5,99,9801 (99 * 99 = 9801)" do
    expect( ShipComputer.execute_listing("2,4,4,5,99,0") ).to eq( "2,4,4,5,99,9801" )
  end

  specify "1,1,1,4,99,5,6,0,99 becomes 30,1,1,4,2,5,6,0,99" do
    expect( ShipComputer.execute_listing("1,1,1,4,99,5,6,0,99") ).to eq( "30,1,1,4,2,5,6,0,99" )
  end

  let(:original_stack) {
    [
      1,  0,   0,   3,
      1,  1,   2,   3,
      1,  3,   4,   3,
      1,  5,   0,   3,
      2,  13,  1,   19,
      1,  6,   19,  23,
      2,  6,   23,  27,
      1,  5,   27,  31,
      2,  31,  9,   35,
      1,  35,  5,   39,
      1,  39,  5,   43,
      1,  43,  10,  47,
      2,  6,   47,  51,
      1,  51,  5,   55,
      2,  55,  6,   59,
      1,  5,   59,  63,
      2,  63,  6,   67,
      1,  5,   67,  71,
      1,  71,  6,   75,
      2,  75,  10,  79,
      1,  79,  5,   83,
      2,  83,  6,   87,
      1,  87,  5,   91,
      2,  9,   91,  95,
      1,  95,  6,   99,
      2,  9,   99,  103,
      2,  9,   103, 107,
      1,  5,   107, 111,
      1,  111, 5,   115,
      1,  115, 13,  119,
      1,  13,  119, 123,
      2,  6,   123, 127,
      1,  5,   127, 131,
      1,  9,   131, 135,
      1,  135, 9,   139,
      2,  139, 6,   143,
      1,  143, 5,   147,
      2,  147, 6,   151,
      1,  5,   151, 155,
      2,  6,   155, 159,
      1,  159, 2,   163,
      1,  9,   163, 0,
      99,
      2,  0,   14,  0,
    ]
  }

  specify "part one" do
    stack = original_stack.dup
    stack[1] = 12
    stack[2] = 2
    ShipComputer.execute_stack(stack)
    expect( stack[0] ).to eq( 10566835 )
  end

  # specify "part two, brute force" do
  #   target_output = 19690720
  #   candidates    = []
  #
  #   (0..99).each do |noun|
  #     (0..99).each do |verb|
  #       stack = original_stack.dup
  #       stack[1] = noun
  #       stack[2] = verb
  #       ShipComputer.execute_stack(stack)
  #       if stack[0] == target_output
  #         candidates << [ noun, verb ]
  #       end
  #     end
  #   end
  #
  #   puts "\ncandidates:"
  #   pp candidates
  # end

  specify "part two, just for posterity" do
    stack = original_stack.dup
    stack[1] = 23
    stack[2] = 47
    ShipComputer.execute_stack(stack)
    expect( stack[0] ).to eq( 19690720 )
  end
end
