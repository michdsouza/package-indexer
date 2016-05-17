class Graph
  class IndexError < StandardError; end
  
  attr_accessor :libraries, :matrix

	def initialize
    @libraries = []
		@matrix = []
	end

  def index(library, dependencies=[])
    return true if find_index(library)
    return false if dependencies_not_indexed?(library, dependencies)
    add(library)
    library_index = find_index(library)
    add_dependencies(library_index, dependencies) 
    true
  end

  def remove(library, dependencies=[])
    library_index = find_index(library)
    return true if removed?(library_index)
    return false if is_a_dependency?(library_index)
    remove_from_matrix(library_index)
    remove_from_libraries(library)
    true
  end

  def query(library, dependencies=[])
    find_index(library) != nil
  end

  def add_dependencies(library_index, dependencies)
    dependencies.each do |dependency|
      dependency_index = find_index(dependency)
      matrix[library_index][dependency_index] = true
    end
  end

  def add(library)
    libraries << library
    matrix << []
  end

  def find_index(library)
    libraries.index(library)
  end

  def dependencies_not_indexed?(library, dependencies)
    !dependencies.empty? && !(dependencies - libraries).empty?
  end

  def is_a_dependency?(library_index)
    matrix.map { |a| a[library_index] == true }.any?
  end

  private

  def removed?(library_index)
    library_index.nil?
  end

  def remove_from_libraries(library)
    libraries.delete(library)
  end

  # Removes column from matrix
  # Removes row from matrix
  def remove_from_matrix(library_index)
    matrix.map {|row| row.slice!(library_index) }
    matrix.slice!(library_index)
  end

end