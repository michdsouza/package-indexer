require './lib/graph.rb'

class InputProcessor

  def initialize
    @graph ||= Graph.new
  end

  def process(input)
    return "ERROR\n" unless valid?(input)

    command, package, dependencies = input.chomp.split('|')
    case command
    when 'INDEX'
      message(@graph.add_from_command(package, dependency_array(dependencies)))
    when 'REMOVE'
      message(@graph.remove(package))
    when 'QUERY'
      message(@graph.query(package))
    else
      "ERROR\n"
    end
  end

  private

  def valid?(input)
    !input.nil? && input =~ /(.+)\|(.+)\|(.*)/
  end

  def message(result)
    result ? "OK\n" : "FAIL\n"
  end

  def dependency_array(dependencies)
    dependencies.nil? ? [] : dependencies.split(',')
  end

end