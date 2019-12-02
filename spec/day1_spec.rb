require 'spec_helper'
require LIB.join("day1")

RSpec.describe 'fuel requirements' do
  let(:module_weights) {
    [
      85364,  97431,  135519, 119130, 137800, 85946,  146593, 141318, 103590, 138858, 92329,
      94292,  132098, 144266, 72908,  112896, 87046,  133058, 141121, 74681,  83458,  107417,
      121426, 66005,  106094, 96458,  113316, 142676, 79186,  55480,  147821, 116419, 70532,
      105344, 116797, 126387, 139600, 136382, 121330, 123485, 134336, 141201, 131556, 91346,
      117939, 58373,  129325, 102237, 60644,  96712,  126342, 98939,  66305,  111403, 143257,
      58721,  55552,  139078, 74263,  125989, 90904,  91058,  92130,  53176,  81369,  100856,
      110597, 111141, 129749, 123822, 75321,  80963,  102625, 70161,  107069, 117982, 86443,
      95627,  147801, 149508, 101470, 81879,  133396, 82276,  144803, 67049,  127735, 121064,
      122975, 69435,  139132, 141284, 70798,  117921, 108942, 85662,  75438,  122699, 116654,
      126797,
    ]
  }

  specify "For a mass of 12, divide by 3 and round down to get 4, then subtract 2 to get 2." do
    expect( Fuel.for_mass(12) ).to eq( 2 )
  end

  specify "For a mass of 14, dividing by 3 and rounding down still yields 4, so the fuel required is also 2." do
    expect( Fuel.for_mass(14) ).to eq( 2 )
  end

  specify "For a mass of 1969, the fuel required is 654." do
    expect( Fuel.for_mass(1969) ).to eq( 654 )
  end

  specify "For a mass of 100756, the fuel required is 33583." do
    expect( Fuel.for_mass(100756) ).to eq( 33583 )
  end

  specify "puzzle solution" do
    fuels = module_weights.map { |e| Fuel.for_mass(e) }
    total = fuels.inject(0, :+)
    # puts "\n\nTotal fuel required is: #{total}"
    expect( total ).to eq( 3563458 )
  end

  specify "A module of mass 14 requires 2 fuel. This fuel requires no further fuel (2 divided by 3 and rounded down is 0, which would call for a negative fuel), so the total fuel required is still just 2." do
    expect( Fuel.for_mass_including_fuel(14) ).to eq( 2 )
  end

  specify "At first, a module of mass 1969 requires 654 fuel. Then, this fuel requires 216 more fuel (654 / 3 - 2). 216 then requires 70 more fuel, which requires 21 fuel, which requires 5 fuel, which requires no further fuel. So, the total fuel required for a module of mass 1969 is 654 + 216 + 70 + 21 + 5 = 966." do
    expect( Fuel.for_mass_including_fuel(1969 ) ).to eq( 966 )
  end

  specify "The fuel required by a module of mass 100756 and its fuel is: 33583 + 11192 + 3728 + 1240 + 411 + 135 + 43 + 12 + 2 = 50346." do
    expect( Fuel.for_mass_including_fuel(100756) ).to eq( 50346 )
  end

  specify "puzzle solution" do
    fuels = module_weights.map { |e| Fuel.for_mass_including_fuel(e) }
    total = fuels.inject(0, :+)
    # puts "\n\nACTUAL total fuel required is: #{total}"
    expect( total ).to eq( 5342292 )
  end
end
