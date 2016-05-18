module Operations
  module Query
    def query(package, _dependencies = [])
      found?(package)
    end
  end
end
