require 'spec_helper'
require LIB.join("day4")

RSpec.describe 'password checker' do
  let(:range) { 273025..767253 }

  context "part one" do
    xit "says '111111' is okay" do
      expect( PasswordChecker.ok?(111111) ).to be true
    end

    it "says '223450' is not okay (decreases)" do
      expect( PasswordChecker.ok?(223450) ).to be false
    end

    it "says '123789' is not okay (no double)" do
      expect( PasswordChecker.ok?(123789) ).to be false
    end

    xspecify "solution" do
      candidates = range.select { |e| PasswordChecker.ok?(e) }
      puts ; p candidates
      puts "\n\nThat's #{candidates.length} candidates!"
    end
  end

  context "part two" do
    it "says '111111' is NO LONGER okay" do
      expect( PasswordChecker.ok?(111111) ).to be false
    end

    it "says '112233' is okay" do
      expect( PasswordChecker.ok?(112233) ).to be true
    end

    it "says '123444' is not okay (the '44' is part of a larger group '444')" do
      expect( PasswordChecker.ok?(123444) ).to be false
    end

    it "says '111122' is okay" do
      expect( PasswordChecker.ok?(111122) ).to be true
    end

    xspecify "solution" do
      candidates = range.select { |e| PasswordChecker.ok?(e) }
      puts ; p candidates
      puts "\n\nThat's #{candidates.length} candidates!"
    end
  end
end
