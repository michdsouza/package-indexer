module Operations
  module Remove

    def remove(package, dependencies=[])
      return true if absent?(package)
      return false if is_dependency?(find(package))
      remove_package(package)
    end

    def remove_package(package)
      package_index = find(package)
      remove_from_matrix(package_index)
      libraries.delete_at(package_index)
    end

    def remove_from_matrix(package_index)
      matrix.slice!(package_index)
      matrix.each {|row| row.slice!(package_index) }
    end

    def is_dependency?(package_index)
      matrix.map { |a| a[package_index] == true }.any?
    end  
  end
end