require 'spec_helper'
require LIB.join("day11")

RSpec.describe "N-body silliness" do
  specify "Vectors can be added" do
    v1 = Vector( 1, 2,  3 )
    v2 = Vector( 4, 5, -1 )
    expect( v1+v2 ).to eq( Vector(5, 7, 2) )
  end

  specify "applying gravity between two moons" do
    ganymede = Body.new(3, 0, 0) ; ganymede.name = "Ganymede"
    callisto = Body.new(5, 0, 0) ; callisto.name = "Callisto"

    # Precondition check
    expect( ganymede.position ).to eq( Vector( 3, 0, 0 ) ) ; expect( ganymede.velocity ).to eq( Vector( 0, 0, 0 ) )
    expect( callisto.position ).to eq( Vector( 5, 0, 0 ) ) ; expect( callisto.velocity ).to eq( Vector( 0, 0, 0 ) )

    system = System.new(ganymede, callisto)
    system.send :add_gravity
    expect( ganymede.position ).to eq( Vector( 3, 0, 0 ) ) ; expect( ganymede.velocity ).to eq( Vector( 1, 0, 0 ) )
    expect( callisto.position ).to eq( Vector( 5, 0, 0 ) ) ; expect( callisto.velocity ).to eq( Vector(-1, 0, 0 ) )

    system.send :update_positions
    expect( ganymede.position ).to eq( Vector( 4, 0, 0 ) ) ; expect( ganymede.velocity ).to eq( Vector( 1, 0, 0 ) )
    expect( callisto.position ).to eq( Vector( 4, 0, 0 ) ) ; expect( callisto.velocity ).to eq( Vector(-1, 0, 0 ) )

    system.send :add_gravity
    expect( ganymede.position ).to eq( Vector( 4, 0, 0 ) ) ; expect( ganymede.velocity ).to eq( Vector( 1, 0, 0 ) )
    expect( callisto.position ).to eq( Vector( 4, 0, 0 ) ) ; expect( callisto.velocity ).to eq( Vector(-1, 0, 0 ) )
  end


  context "first example" do
    let(:a) { Body.new( -1,   0,  2 ) }
    let(:b) { Body.new(  2, -10, -7 ) }
    let(:c) { Body.new(  4,  -8,  8 ) }
    let(:d) { Body.new(  3,   5, -1 ) }
    let(:moons) { System.new(a, b, c, d) }

    specify "stepping through and producing output" do
      # Precondition check
      expect( moons.to_s ).to eq(<<~EOF.strip), "step 0"
        pos=<x= -1, y=  0, z=  2>, vel=<x=  0, y=  0, z=  0>
        pos=<x=  2, y=-10, z= -7>, vel=<x=  0, y=  0, z=  0>
        pos=<x=  4, y= -8, z=  8>, vel=<x=  0, y=  0, z=  0>
        pos=<x=  3, y=  5, z= -1>, vel=<x=  0, y=  0, z=  0>
      EOF

      moons.step # 1
      expect( moons.to_s ).to eq(<<~EOF.strip), "step 1"
        pos=<x=  2, y= -1, z=  1>, vel=<x=  3, y= -1, z= -1>
        pos=<x=  3, y= -7, z= -4>, vel=<x=  1, y=  3, z=  3>
        pos=<x=  1, y= -7, z=  5>, vel=<x= -3, y=  1, z= -3>
        pos=<x=  2, y=  2, z=  0>, vel=<x= -1, y= -3, z=  1>
      EOF

      moons.step # 2
      expect( moons.to_s ).to eq(<<~EOF.strip), "step 2"
        pos=<x=  5, y= -3, z= -1>, vel=<x=  3, y= -2, z= -2>
        pos=<x=  1, y= -2, z=  2>, vel=<x= -2, y=  5, z=  6>
        pos=<x=  1, y= -4, z= -1>, vel=<x=  0, y=  3, z= -6>
        pos=<x=  1, y= -4, z=  2>, vel=<x= -1, y= -6, z=  2>
      EOF

      moons.step # 3
      expect( moons.to_s ).to eq(<<~EOF.strip), "step 3"
        pos=<x=  5, y= -6, z= -1>, vel=<x=  0, y= -3, z=  0>
        pos=<x=  0, y=  0, z=  6>, vel=<x= -1, y=  2, z=  4>
        pos=<x=  2, y=  1, z= -5>, vel=<x=  1, y=  5, z= -4>
        pos=<x=  1, y= -8, z=  2>, vel=<x=  0, y= -4, z=  0>
      EOF

      moons.step # 4
      expect( moons.to_s ).to eq(<<~EOF.strip), "step 4"
        pos=<x=  2, y= -8, z=  0>, vel=<x= -3, y= -2, z=  1>
        pos=<x=  2, y=  1, z=  7>, vel=<x=  2, y=  1, z=  1>
        pos=<x=  2, y=  3, z= -6>, vel=<x=  0, y=  2, z= -1>
        pos=<x=  2, y= -9, z=  1>, vel=<x=  1, y= -1, z= -1>
      EOF

      moons.step # 5
      expect( moons.to_s ).to eq(<<~EOF.strip), "step 5"
        pos=<x= -1, y= -9, z=  2>, vel=<x= -3, y= -1, z=  2>
        pos=<x=  4, y=  1, z=  5>, vel=<x=  2, y=  0, z= -2>
        pos=<x=  2, y=  2, z= -4>, vel=<x=  0, y= -1, z=  2>
        pos=<x=  3, y= -7, z= -1>, vel=<x=  1, y=  2, z= -2>
      EOF

      moons.step # 6
      expect( moons.to_s ).to eq(<<~EOF.strip), "step 6"
        pos=<x= -1, y= -7, z=  3>, vel=<x=  0, y=  2, z=  1>
        pos=<x=  3, y=  0, z=  0>, vel=<x= -1, y= -1, z= -5>
        pos=<x=  3, y= -2, z=  1>, vel=<x=  1, y= -4, z=  5>
        pos=<x=  3, y= -4, z= -2>, vel=<x=  0, y=  3, z= -1>
      EOF

      moons.step # 7
      expect( moons.to_s ).to eq(<<~EOF.strip), "step 7"
        pos=<x=  2, y= -2, z=  1>, vel=<x=  3, y=  5, z= -2>
        pos=<x=  1, y= -4, z= -4>, vel=<x= -2, y= -4, z= -4>
        pos=<x=  3, y= -7, z=  5>, vel=<x=  0, y= -5, z=  4>
        pos=<x=  2, y=  0, z=  0>, vel=<x= -1, y=  4, z=  2>
      EOF

      moons.step # 8
      expect( moons.to_s ).to eq(<<~EOF.strip), "step 8"
        pos=<x=  5, y=  2, z= -2>, vel=<x=  3, y=  4, z= -3>
        pos=<x=  2, y= -7, z= -5>, vel=<x=  1, y= -3, z= -1>
        pos=<x=  0, y= -9, z=  6>, vel=<x= -3, y= -2, z=  1>
        pos=<x=  1, y=  1, z=  3>, vel=<x= -1, y=  1, z=  3>
      EOF

      moons.step # 9
      expect( moons.to_s ).to eq(<<~EOF.strip), "step 9"
        pos=<x=  5, y=  3, z= -4>, vel=<x=  0, y=  1, z= -2>
        pos=<x=  2, y= -9, z= -3>, vel=<x=  0, y= -2, z=  2>
        pos=<x=  0, y= -8, z=  4>, vel=<x=  0, y=  1, z= -2>
        pos=<x=  1, y=  1, z=  5>, vel=<x=  0, y=  0, z=  2>
      EOF

      moons.step # 10
      expect( moons.to_s ).to eq(<<~EOF.strip), "step 10"
        pos=<x=  2, y=  1, z= -3>, vel=<x= -3, y= -2, z=  1>
        pos=<x=  1, y= -8, z=  0>, vel=<x= -1, y=  1, z=  3>
        pos=<x=  3, y= -6, z=  1>, vel=<x=  3, y=  2, z= -3>
        pos=<x=  2, y=  0, z=  4>, vel=<x=  1, y= -1, z= -1>
      EOF
    end

    specify "calculating energy" do
      10.times { moons.step }
      expect( a.potential_energy ).to eq(  6 ) ; expect( a.kinetic_energy ).to eq( 6 ) ; expect( a.total_energy ).to eq( 36 )
      expect( b.potential_energy ).to eq(  9 ) ; expect( b.kinetic_energy ).to eq( 5 ) ; expect( b.total_energy ).to eq( 45 )
      expect( c.potential_energy ).to eq( 10 ) ; expect( c.kinetic_energy ).to eq( 8 ) ; expect( c.total_energy ).to eq( 80 )
      expect( d.potential_energy ).to eq(  6 ) ; expect( d.kinetic_energy ).to eq( 3 ) ; expect( d.total_energy ).to eq( 18 )
    end
  end

  context "second example" do
    let(:a) { Body.new( -8, -10,  0 ) }
    let(:b) { Body.new(  5,   5, 10 ) }
    let(:c) { Body.new(  2,  -7,  3 ) }
    let(:d) { Body.new(  9,  -8, -3 ) }
    let(:moons) { System.new(a, b, c, d) }

    specify "stepping through output" do
      100.times { moons.step }

      expect( moons.to_s ).to eq(<<~EOF.strip), "step 10"
        pos=<x=  8, y=-12, z= -9>, vel=<x= -7, y=  3, z=  0>
        pos=<x= 13, y= 16, z= -3>, vel=<x=  3, y=-11, z= -5>
        pos=<x=-29, y=-11, z= -1>, vel=<x= -3, y=  7, z=  4>
        pos=<x= 16, y=-13, z= 23>, vel=<x=  7, y=  1, z=  1>
      EOF

      expect( moons.total_energy ).to eq( 1940 )
    end
  end

  context "puzzle input" do
    let(:a) { Body.new( -14, -4, -11 ) }
    let(:b) { Body.new( -9,   6,  -7 ) }
    let(:c) { Body.new(  4,   1,   4 ) }
    let(:d) { Body.new(  2, -14,  -9 ) }
    let(:moons) { System.new(a, b, c, d) }

    specify "part one" do
      1_000.times { moons.step }
      puts "total energy is #{moons.total_energy}"
    end
  end

end
