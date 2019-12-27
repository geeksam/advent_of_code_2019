require 'spec_helper'
require LIB.join("day24")

RSpec.describe "N-body silliness" do

  describe "initial example" do
    let(:board_text) {
      <<~EOF.strip
        ....#
        #..#.
        #..##
        ..#..
        #....
      EOF
    }
    let(:board) { BugBoard.new(board_text) }

    it "knows how to print itself out again" do
      expect( board.to_s ).to eq( board_text )
    end

    it "knows where the bugs are" do
      expect( board.at(0,0) ).to be nil
      expect( board.at(4,0) ).to be :bug
      expect( board.at(0,1) ).to be :bug
      expect( board.at(1,1) ).to be nil
    end

    it "knows where the neighbors of various points are" do
      expect( board.neighbors_of(2,2) ).to eq(
        [
          [2, 1], # north
          [3, 2], # east
          [2, 3], # south
          [1, 2], # west
        ]
      )
      expect( board.neighbors_of(3,3) ).to eq(
        [
          [3, 2], # north
          [4, 3], # east
          [3, 4], # south
          [2, 3], # west
        ]
      )
      expect( board.neighbors_of(1,0) ).to eq(
        [
          [2, 0], # east
          [1, 1], # south
          [0, 0], # west
        ]
      )
      expect( board.neighbors_of(0,0) ).to eq(
        [
          [1, 0], # east
          [0, 1], # south
        ]
      )
    end

    let(:board_text_after_one_minute) {
      <<~EOF.strip
				#..#.
				####.
				###.#
				##.##
				.##..
      EOF
    }
    let(:board_text_after_two_minutes) {
      <<~EOF.strip
        #####
        ....#
        ....#
        ...#.
        #.###
      EOF
    }
    let(:board_text_after_three_minutes) {
      <<~EOF.strip
        #....
        ####.
        ...##
        #.##.
        .##.#
      EOF
    }
    let(:board_text_after_four_minutes) {
      <<~EOF.strip
        ####.
        ....#
        ##..#
        .....
        ##...
      EOF
    }
    it "can iterate" do
      board.tick ; expect( board.to_s ).to eq( board_text_after_one_minute )
      board.tick ; expect( board.to_s ).to eq( board_text_after_two_minutes )
      board.tick ; expect( board.to_s ).to eq( board_text_after_three_minutes )
      board.tick ; expect( board.to_s ).to eq( board_text_after_four_minutes )
    end

    it "knows the first layout that appears twice" do
      expect( board.first_repeated_layout ).to eq( <<~EOF.strip )
        .....
        .....
        .....
        #....
        .#...
      EOF

      expect( board.to_s ).to eq( board_text )
    end

    specify "BugBoard class knows the 'biodiversity score' of the first layout that appears twice" do
      layout = board.first_repeated_layout
      expect( BugBoard.biodiversity_score(layout) ).to eq( 32_768 + 2_097_152 )
    end
  end

  context "part one" do
    let(:board_text) {
      <<~EOF.strip
				#.#..
				.....
				.#.#.
				.##..
				.##.#
      EOF
    }
    let(:board) { BugBoard.new(board_text) }

    specify "BugBoard class knows the 'biodiversity score' of the first layout that appears twice" do
      layout = board.first_repeated_layout
      expect( BugBoard.biodiversity_score(layout) ).to eq( 32_776_479 )
    end
  end

end
