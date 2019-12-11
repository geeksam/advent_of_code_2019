require 'spec_helper'
require LIB.join("intcode_computer")

RSpec.describe "IntcodeComputer, day nine" do
  let(:listing1) { "109,1,204,-1,1001,100,1,100,1008,100,16,101,1006,101,0,99" }
  let(:listing2) { "1102,34915192,34915192,7,4,7,99,0" }
  let(:listing3) { "104,1125899906842624,99" }

#   specify "first example umwhat" do
# # $debug = true
#     io = { input: [], output: [] }
#     IntcodeComputer.execute_listing(listing1, **io)
#     puts ; p io
#     # expect( io ).to eq( { input: [], output: [42] } )
#   end
end
