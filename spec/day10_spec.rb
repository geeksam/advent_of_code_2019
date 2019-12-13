require 'spec_helper'
require LIB.join("day10")

RSpec.describe "asteroids" do
  describe "smallest map" do
    let(:map_text) {
      <<~EOF.strip
        .#..#
        .....
        #####
        ....#
        ...##
      EOF
    }
    subject(:map) { AsteroidMap.from_text(map_text) }
    let(:p1) { Point(1,0) } ; let(:p2) { Point(4,0) } ; let(:p3) { Point(4,3) }
    let(:a1) { map[p1] }    ; let(:a2) { map[p2] }    ; let(:a3) { map[p3] }

    it "knows where the asteroids are and aren't" do
      expect( map[ Point(0,0) ] ).to be nil
      expect( map[ Point(1,0) ] ).to be_kind_of( Asteroid )
    end

    it "knows all the points on a line between two arbitrary points" do
      points = map.points_between( Point(0,0), Point(4,0) )
      expect( points ).to eq( [ Point(1,0), Point(2,0), Point(3,0) ] )

      points = map.points_between( Point(0,0), Point(4,4) )
      expect( points ).to eq( [ Point(1,1), Point(2,2), Point(3,3) ] )

      points = map.points_between( Point(0,0), Point(4,2) )
      expect( points ).to eq( [ Point(2,1) ] )
    end

    it "knows all the objects between two arbitrary points" do
      a, b = Point(4,0), Point(4,4)
      objects = map.objects_between(a, b)
      expect( objects.length ).to eq( 2 )
      expect( objects.all? { |e| e.kind_of?(Asteroid) } ).to be true
      expect( objects.map(&:point).sort ).to eq( [ Point(4,2), Point(4,3) ] )
    end

    specify "two asteroids can see each other iff there are no other asteroids at any of the points between them" do
      #       .1..2   1 & 2 can see each other
      #       .....
      #       #####
      #       ....3   neither can see 3
      #       ...##
      p1, p2, p3 = Point(1,0), Point(4,0), Point(4,3)
      a1, a2, a3 = map[p1], map[p2], map[p3]
      expect( a1.can_see?(a2) ).to be true  ; expect( a2.can_see?(a1) ).to be true
      expect( a1.can_see?(a3) ).to be false ; expect( a3.can_see?(a1) ).to be false
      expect( a2.can_see?(a3) ).to be false ; expect( a3.can_see?(a2) ).to be false
    end

    specify "num_asteroids_detectable_from" do
      expect( map.num_asteroids_detectable_from( Point(1,0) ) ).to eq( 7 )
      expect( map.num_asteroids_detectable_from( Point(0,2) ) ).to eq( 6 )
      expect( map.num_asteroids_detectable_from( Point(4,2) ) ).to eq( 5 )
    end

    specify "optimal_monitoring_location" do
      point, score = map.optimal_monitoring_location
      expect( point ).to eq( Point(3,4) )
      expect( score ).to eq( 8 )
    end
  end

  describe "other maps" do
    let(:map2_text) {
      <<~EOF.strip
        ......#.#.
        #..#.#....
        ..#######.
        .#.#.###..
        .#..#.....
        ..#....#.#
        #..#....#.
        .##.#..###
        ##...#..#.
        .#....####
      EOF
    }
    let(:map3_text) {
      <<~EOF.strip
				#.#...#.#.
				.###....#.
				.#....#...
				##.#.#.#.#
				....#.#.#.
				.##..###.#
				..#...##..
				..##....##
				......#...
				.####.###.
      EOF
    }
    let(:map4_text) {
      <<~EOF.strip
				.#..#..###
				####.###.#
				....###.#.
				..###.##.#
				##.##.#.#.
				....###..#
				..#.#..#.#
				#..#.#.###
				.##...##.#
				.....#.#..
      EOF
    }
    let(:map5_text) {
      <<~EOF.strip
        .#..##.###...#######
        ##.############..##.
        .#.######.########.#
        .###.#######.####.#.
        #####.##.#.##.###.##
        ..#####..#.#########
        ####################
        #.####....###.#.#.##
        ##.#################
        #####.##.###..####..
        ..######..##.#######
        ####.##.####...##..#
        .#####..#.######.###
        ##...#.##########...
        #.##########.#######
        .####.#.###.###.#.##
        ....##.##.###..#####
        .#.#.###########.###
        #.#.#.#####.####.###
        ###.##.####.##.#..##
      EOF
    }
    subject(:map2) { AsteroidMap.from_text(map2_text) }
    subject(:map3) { AsteroidMap.from_text(map3_text) }
    subject(:map4) { AsteroidMap.from_text(map4_text) }
    subject(:map5) { AsteroidMap.from_text(map5_text) }

    specify "map 2 optimal_monitoring_location" do
      point, score = map2.optimal_monitoring_location
      expect( point ).to eq( Point(5,8) )
      expect( score ).to eq( 33 )
    end

    specify "map 3 optimal_monitoring_location" do
      point, score = map3.optimal_monitoring_location
      expect( point ).to eq( Point(1,2) )
      expect( score ).to eq( 35 )
    end

    specify "map 4 optimal_monitoring_location" do
      point, score = map4.optimal_monitoring_location
      expect( point ).to eq( Point(6,3) )
      expect( score ).to eq( 41 )
    end

    # specify "map 5 optimal_monitoring_location" do
    #   point, score = map5.optimal_monitoring_location
    #   expect( point ).to eq( Point(11,13) )
    #   expect( score ).to eq( 210 )
    # end
  end

  let(:puzzle_input) {
    <<~EOF.strip
      #....#.....#...#.#.....#.#..#....#
      #..#..##...#......#.....#..###.#.#
      #......#.#.#.....##....#.#.....#..
      ..#.#...#.......#.##..#...........
      .##..#...##......##.#.#...........
      .....#.#..##...#..##.....#...#.##.
      ....#.##.##.#....###.#........####
      ..#....#..####........##.........#
      ..#...#......#.#..#..#.#.##......#
      .............#.#....##.......#...#
      .#.#..##.#.#.#.#.......#.....#....
      .....##.###..#.....#.#..###.....##
      .....#...#.#.#......#.#....##.....
      ##.#.....#...#....#...#..#....#.#.
      ..#.............###.#.##....#.#...
      ..##.#.........#.##.####.........#
      ##.#...###....#..#...###..##..#..#
      .........#.#.....#........#.......
      #.......#..#.#.#..##.....#.#.....#
      ..#....#....#.#.##......#..#.###..
      ......##.##.##...#...##.#...###...
      .#.....#...#........#....#.###....
      .#.#.#..#............#..........#.
      ..##.....#....#....##..#.#.......#
      ..##.....#.#......................
      .#..#...#....#.#.....#.........#..
      ........#.............#.#.........
      #...#.#......#.##....#...#.#.#...#
      .#.....#.#.....#.....#.#.##......#
      ..##....#.....#.....#....#.##..#..
      #..###.#.#....#......#...#........
      ..#......#..#....##...#.#.#...#..#
      .#.##.#.#.....#..#..#........##...
      ....#...##.##.##......#..#..##....
    EOF
  }
  subject(:puzzle_map) { AsteroidMap.from_text(puzzle_input) }
  describe "part one" do

    # specify "solution" do
    #   point, score = puzzle_map.optimal_monitoring_location
    #   expect( point ).to eq( Point(26,28) )
    #   expect( score ).to eq( 267 )
    # end
  end

  describe "part two" do
    specify "a Point can convert itself to polar coordinates relative to an arbitrary origin" do
      nw = Point(0,  0) ; n = Point(5,  0) ; ne = Point(10,  0)
      w  = Point(0,  5) ; x = Point(5,  5) ; e  = Point(10,  5)
      sw = Point(0, 10) ; s = Point(5, 10) ; se = Point(10, 10)

      r = Math.sqrt( 5**2 + 5**2 ).round(3)
      expect( n .to_polar(x) ).to eq( Polar( 90,  5 ) )
      expect( ne.to_polar(x) ).to eq( Polar( 45,  r ) )
      expect( e .to_polar(x) ).to eq( Polar( 0,   5 ) )
      expect( se.to_polar(x) ).to eq( Polar( 315, r ) )
      expect( s .to_polar(x) ).to eq( Polar( 270, 5 ) )
      expect( sw.to_polar(x) ).to eq( Polar( 225, r ) )
      expect( w .to_polar(x) ).to eq( Polar( 180, 5 ) )
      expect( nw.to_polar(x) ).to eq( Polar( 135, r ) )
    end

    let(:laser_example_text) {
      <<~EOF
				.#....#####...#..
				##...##.#####..##
				##...#...#.#####.
				..#.....X...###..
				..#.#.....#....##
      EOF
    }
    let(:laser_map) { AsteroidMap.from_text(laser_example_text) }

    specify "X marks the spot" do
      expect( laser_map.polar_origin ).to eq( Point(8,3) )
    end

    specify "annihilation_queue" do
      boom = laser_map.annihilation_queue.to_enum

      expect( boom.next ).to eq( Point( 8, 1) )
      expect( boom.next ).to eq( Point( 9, 0) )
      expect( boom.next ).to eq( Point( 9, 1) )
      expect( boom.next ).to eq( Point(10, 0) )
      expect( boom.next ).to eq( Point( 9, 2) )
      expect( boom.next ).to eq( Point(11, 1) )
      expect( boom.next ).to eq( Point(12, 1) )
      expect( boom.next ).to eq( Point(11, 2) )
      expect( boom.next ).to eq( Point(15, 1) )

      expect( boom.next ).to eq( Point(12, 2) )
      expect( boom.next ).to eq( Point(13, 2) )
      expect( boom.next ).to eq( Point(14, 2) )
      expect( boom.next ).to eq( Point(15, 2) )
      expect( boom.next ).to eq( Point(12, 3) )
      expect( boom.next ).to eq( Point(16, 4) )
      expect( boom.next ).to eq( Point(15, 4) )
      expect( boom.next ).to eq( Point(10, 4) )
      expect( boom.next ).to eq( Point( 4, 4) )
    end

    # specify "solution" do
    #   laser = Point(26,28)
    #   puzzle_map.polar_origin = laser
    #   boom = puzzle_map.annihilation_queue.to_enum
    #   199.times { boom.next }
    #   expect( boom.next ).to eq( Point(13,9) )
    # end
  end
end
