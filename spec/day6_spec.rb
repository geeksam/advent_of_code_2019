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

  describe "orbital transfer count" do
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
        K)YOU
        I)SAN
      EOF
    }

    specify "basic map stats" do
      expect( map.object_count ).to eq( 14 )
      expect( map.object_names ).to eq( %w[ COM B C D E F G H I J K L SAN YOU ].sort )
    end

    specify "four orbital transfers are required to get YOU to SAN" do
      expect( map.minimum_transfers(from: "YOU", to: "SAN") ).to eq( 4 )
    end
  end

	describe "actual puzzle" do
    let(:map_listing) { read_fixture_file("day6-part1.txt") }
    let(:map) { OrbitMap.new(map_listing) }

    specify "part one: orbit counts" do
      # puts "", map.object_names.join(", ")
      # puts "", map.orbit_count
      expect( map.orbit_count ).to eq( 142915 )
    end

    specify "part two: orbital transfers" do
      # puts "", map.object_names.join(", ")
      # puts "", map.minimum_transfers(from: "YOU", to: "SAN")
      expect( map.minimum_transfers(from: "YOU", to: "SAN") ).to eq( 283 )
    end
  end

end
