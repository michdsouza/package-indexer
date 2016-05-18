require "./lib/graph.rb"

class InputProcessor
  OK = "OK\n".freeze
  FAIL = "FAIL\n".freeze
  ERROR = "ERROR\n".freeze

  VALID_COMMANDS = %w(INDEX REMOVE QUERY).freeze

  def initialize
    @graph ||= Graph.new
  end

  def process(input)
    return ERROR unless valid_syntax?(input)

    command, package, dependencies = input.chomp.split("|")
    valid_command?(command) ? message(@graph.send(symbolize(command), package, to_array(dependencies))) : ERROR
  end

  def valid_syntax?(input)
    !input.nil? &&
      input.count("|") == 2 &&
      !!(input =~ /(.+)\|(.+)\|(.*)/)
  end

  def valid_command?(command)
    VALID_COMMANDS.include?(command)
  end

  def message(result)
    result ? OK : FAIL
  end

  def to_array(dependencies)
    dependencies.nil? ? [] : dependencies.split(",")
  end

  private

  def symbolize(command)
    command.downcase.to_sym
  end
end
