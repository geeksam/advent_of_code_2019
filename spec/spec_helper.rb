require 'pathname'
LIB = Pathname.new(File.dirname(__FILE__)).join("../lib")

require 'pp'

RSpec.configure do |c|
  c.filter_run_when_matching :focus

  c.after :example do
    $debug = false
  end
end
