require 'spec_helper'
require LIB.join("day6")

RSpec.describe 'orbital graphs' do
  describe "extremely simple map" do
    let(:map) { OrbitMap.new("AAA)BBB") }

    it "has two objects" do
      expect( map.object_count ).to eq( 2 )
      expect( map.object_names ).to eq( [ "AAA", "BBB" ] )
    end

    specify "its orbit count is 1" do
      expect( map.orbit_count ).to eq( 1 )
    end
  end

  describe "example map" do
    let(:map) {
      OrbitMap.new(<<~EOF.strip)
        COM)B
        B)C
        C)D
        D)E
        E)F
        B)G
        G)H
        D)I
        E)J
        J)K
        K)L
      EOF
    }

    it "has 12 objects" do
      expect( map.object_count ).to eq( 12 )
      expect( map.object_names ).to eq( %w[ COM B C D E F G H I J K L ].sort )
    end

    specify "its orbit count is 42" do
      expect( map.orbit_count ).to eq( 42 )
    end
  end

	describe "actual puzzle" do
    let(:map_listing) { File.read( Pathname.new(File.dirname(__FILE__)).join("day6-part1.txt") ) }
    let(:map) { OrbitMap.new(map_listing) }

    specify "part one: orbit counts" do
      # puts "", map.object_names.join(", ")
      # puts "", map.orbit_count
      expect( map.orbit_count ).to eq( 142915 )
    end
  end

end
