require 'spec_helper'
require LIB.join("day4")

RSpec.describe 'password checker' do
  context "part one" do
    it "says '111111' is okay" do
      expect( PasswordChecker.ok?(111111) ).to be true
    end

    it "says '223450' is not okay (decreases)" do
      expect( PasswordChecker.ok?(223450) ).to be false
    end

    it "says '123789' is not okay (no double)" do
      expect( PasswordChecker.ok?(123789) ).to be false
    end

    xspecify "solution" do
      range = 273025..767253
      candidates = range.select { |e| PasswordChecker.ok?(e) }
      puts ; p candidates
      puts "\n\nThat's #{candidates.length} candidates!"
    end
  end
end
