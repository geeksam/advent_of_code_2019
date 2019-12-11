require 'spec_helper'
require LIB.join("day8")

RSpec.describe 'space image format' do
  let(:example1) { SIF.new('123456789012', width: 3, height: 2) }
  let(:example2) { SIF.new('0222112222120000', width: 2, height: 2) }
  let(:puzzle_input) { read_fixture_file("day8-input.txt") }
  let(:puzzle_image) { SIF.new(puzzle_input, width: 25, height: 6) }

  specify "it knows how many layers it has" do
    expect( example1.layers.count ).to eq( 2 )
  end

  specify "it knows which layer has the fewest zeros (srsly)" do
    expect( example1.layer_with_fewest(0).inspect ).to eq( "123\n456" )
  end

  specify "it can iterate its pixels in the correct order" do
    out = []
    example1.layers.each do |layer|
      layer.each_pixel do |x,y,n|
        out << n
      end
    end
    expect( out ).to eq( (1..9).to_a + [ 0, 1, 2 ] )
  end

  specify "part one" do
    layer = puzzle_image.layer_with_fewest(0)
    x = layer.count_of(1) * layer.count_of(2)
    expect( x ).to eq( 2760 )
  end

  specify "rendering example image" do
    expect( example2.flatten_for_inspection ).to eq( "01\n10" )
  end

  specify "printing example image" do
    expect( example2.to_s ).to eq( " #\n# " )
  end

  specify "part two" do
    strip_trailing = ->(s) { s.to_s.lines.map(&:rstrip).join("\n") }
    expect( strip_trailing.(puzzle_image) ).to eq( strip_trailing.(<<~EOF) )
        ##   ##  #  # #### ###
       #  # #  # #  # #    #  #
       #  # #    #  # ###  ###
       #### # ## #  # #    #  #
       #  # #  # #  # #    #  #
       #  #  ###  ##  #### ###
    EOF
  end
end
