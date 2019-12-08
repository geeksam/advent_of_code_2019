require 'spec_helper'
require LIB.join("day8")

RSpec.describe 'space image format' do
  let(:example) { SIF.new('123456789012', width: 3, height: 2) }
  let(:puzzle_input) { File.read( Pathname.new(File.dirname(__FILE__)).join("day8-input.txt") ) }
  let(:puzzle_image) { SIF.new(puzzle_input, width: 25, height: 6) }

  specify "it knows how many layers it has" do
    expect( example.layers.count ).to eq( 2 )
  end

  specify "it knows which layer has the fewest zeros (srsly)" do
    expect( example.layer_with_fewest(0).inspect ).to eq( "123\n456" )
  end

  specify "part one" do
    layer = puzzle_image.layer_with_fewest(0)
    x = layer.count_of(1) * layer.count_of(2)
    expect( x ).to eq( 2760 )
  end
end
