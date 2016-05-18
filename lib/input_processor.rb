require './lib/graph.rb'

class InputProcessor

  OK = "OK\n".freeze
  FAIL = "FAIL\n".freeze
  ERROR = "ERROR\n".freeze

  VALID_COMMANDS = %w(INDEX REMOVE QUERY).freeze

  def initialize
    @graph ||= Graph.new
  end

  def process(input)
    return ERROR if invalid?(input)

    command, package, dependencies = input.chomp.split("|")
    VALID_COMMANDS.include?(command) ? message(@graph.send(command.downcase.to_sym, package, to_array(dependencies))) : ERROR
  end

  def invalid?(input)
    input.nil? || input !~ /(.+)\|(.+)\|(.*)/
  end

  def message(result)
    result ? OK : FAIL
  end

  def to_array(dependencies)
    dependencies.nil? ? [] : dependencies.split(",")
  end

end