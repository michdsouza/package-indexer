class Graph
  class IndexError < StandardError; end
  
  attr_accessor :libraries, :matrix

	def initialize
    @libraries = []
		@matrix = []
	end

  def add(library)
    libraries << library
    matrix << []
  end

  def query(library)
    !find_index(library).nil?
  end

  def find_index(library)
    libraries.index(library)
  end

  def dependency?(library_index)
    matrix.map { |a| a[library_index] == true }.any?
  end

  def remove(library)
    library_index = find_index(library)
    return false unless can_be_removed?(library_index)
    remove_from_matrix(library_index)
    remove_from_libraries(library)
    true
  end

  def add_from_command(library, dependencies=[])
    library_index = find_index(library)
    return true if library_index
    return false if !dependencies.empty? && !(dependencies - libraries).empty?
    add(library)
    library_index = find_index(library)
    add_dependencies(library_index, dependencies) 
    true
  end

  def add_dependencies(library_index, dependencies)
    dependencies.each do |dependency|
      dependency_index = find_index(dependency)
      matrix[library_index][dependency_index] = true
    end
  end

  private

  def can_be_removed?(library_index)
    !library_index.nil? && !dependency?(library_index)
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