require 'colorize'

class SimpleTest

  attr_accessor :cases, :tests, :assertions, :passing, :failing, :benchmark

  def initialize
    @cases = 0
    @tests = 0
    @assertions = 0
    @passing = 0
    @failing = 0
  end

  def test(spec)
    @tests += 1
    puts "\t" + spec
    yield
  end

  def test_case(name = nil)
    @cases += 1
    puts "\nCase #{cases}: #{name}\n".cyan
    yield name
  end

  def assert_equal(a, b, error = "fail: compared: #{a} == #{b}")
    @assertions += 1
    if a == b
      pass
    else
      fail error
    end
  end

  def pass(message = 'pass')
    @passing += 1
    puts "\t\t" + message.green
  end

  def fail(message)
    @failing += 1
    puts "\t\t" + message.red
  end

  def result
    total_result = "Ran #{tests} tests (#{@benchmark} seconds)".cyan
    pass_result = "#{passing} passing".green
    fail_result = "#{failing} failing".red
    if failing == 0
      fail_result = fail_result.green
    end
    puts
    puts [total_result, pass_result, fail_result].join ', '
    puts
  end

  def self.batch(tests)
    tests.each do |test|
      test.new.run
    end
  end

  def purge_folder(path)
    FileUtils.rm_f Dir.glob("#{path}/*")
  end
end

