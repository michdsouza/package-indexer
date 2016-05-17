require './lib/graph.rb'

class InputProcessor

  def initialize
    @graph ||= Graph.new
  end

  def process(input)
    return "ERROR\n" if invalid?(input)

    command, package, dependencies = input.chomp.split('|')
    command_sym = command.downcase.to_sym
    @graph.respond_to?(command_sym) ? message(@graph.send(command_sym, package, to_array(dependencies))) : "ERROR\n"
  end

  def invalid?(input)
    input.nil? || input !~ /(.+)\|(.+)\|(.*)/
  end

  def message(result)
    return "FAIL\n" unless result
    "OK\n"
    # result ? "OK\n" : "FAIL\n"
  end

  def to_array(dependencies)
    dependencies.nil? ? [] : dependencies.split(',')
  end

end