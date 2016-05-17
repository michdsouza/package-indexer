module Operations
  module Index
    
    def index(package, dependencies=[])
      return true if found?(package)
      return false if dependencies_absent?(package, dependencies)
      add_package(package, dependencies)
      true
    end

    def add_package(package, dependencies)
      libraries << package
      add_dependencies(package, dependencies) 
    end

    def add_dependencies(package, dependencies)
      package_index = find(package)
      matrix << []
      dependencies.each do |dependency|
        dependency_index = find(dependency)
        matrix[package_index][dependency_index] = true
      end
    end

    def dependencies_absent?(package, dependencies)
      !dependencies.empty? && !(dependencies - libraries).empty?
    end

  end
end