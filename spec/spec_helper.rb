require 'pathname'
LIB = Pathname.new(File.dirname(__FILE__)).join("../lib")

require 'pp'

RSpec.configure do |c|
  c.filter_run_when_matching :focus

  c.after :example do
    $debug = false
  end
end

def fixture_file(basename)
  Pathname.new(File.dirname(__FILE__)).join("fixtures", basename)
end
def read_fixture_file(basename)
  filename = fixture_file(basename)
  File.read(filename)
end
