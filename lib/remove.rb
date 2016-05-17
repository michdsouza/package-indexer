module Operations
  module Remove

    def remove(package, dependencies=[])
      return true if absent?(package)
      return false if is_dependency?(find(package))
      remove_package(package)
      true
    end

    def remove_package(package)
      remove_from_matrix(package)
      libraries.delete(package)
    end

    def remove_from_matrix(package)
      package_index = find(package)
      matrix.map {|row| row.slice!(package_index) }
      matrix.slice!(package_index)
    end

    def is_dependency?(package_index)
      matrix.map { |a| a[package_index] == true }.any?
    end
  
  end
end