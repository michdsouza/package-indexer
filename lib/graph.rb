class Graph
  attr_accessor :nodes, :matrix

	def initialize()
    @nodes = []
		@matrix = []
	end

  def add_from_command(library, dependencies=[])
    library_index = find_node(library)
    return true if library_index
    return false if !dependencies.empty? && !(dependencies - nodes).empty?
    library_index = add(library)
    add_dependencies(library_index, dependencies) 
    true
  end

  def add(node)
    nodes << node
    matrix << []
    # Return node index
    nodes.length - 1 
  end

  def find_node(node)
    nodes.index(node)
  end

  def add_dependencies(library_index, dependencies)
    dependencies.each do |dependency|
      dependency_index = find_node(dependency)
      matrix[library_index][dependency_index] = true
    end
  end

  def remove(library)
    return if dependency?(library)
    library_index = find_node(library)
    # Remove column from matrix
    matrix.map {|row| row.slice!(library_index) }
    # Remove row from matrix
    matrix.slice!(library_index)
    # Remove from nodes
    nodes.delete(library)
  end

  def dependency?(library)
    library_index = find_node(library)
    library_index.nil? ? false : matrix.map { |a| a[library_index] == true }.any?
  end

end

# matrix[*][col] == true is list of libraries needing col dependency
# matrix[row][*] == true is libraries list of dependencies