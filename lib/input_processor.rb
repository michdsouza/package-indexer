class InputProcessor

  def initialize(input, graph)
    @input = input
    @graph = graph
  end

  def process
    # raise error if @input is nil
    command, package, dependencies = @input.chomp.split('|')
    case command
    when 'INDEX'
      message(@graph.add_from_command(package, dependency_array(dependencies)))
    when 'REMOVE'
      message(@graph.remove(package))
    when 'QUERY'
      message(@graph.query(package))
    else
      "FAIL\n"
    end
  end

  private

  def message(result)
    result ? "OK\n" : "FAIL\n"
  end

  def dependency_array(dependencies)
    dependencies.nil? ? [] : [dependencies]
  end

end