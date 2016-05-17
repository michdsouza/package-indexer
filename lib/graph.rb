require './lib/index.rb'
require './lib/remove.rb'
require './lib/query.rb'

class Graph
  include Operations::Index
  include Operations::Remove
  include Operations::Query

  attr_accessor :libraries, :matrix

	def initialize
    @libraries = []
		@matrix = []
	end

  def find(package)
    libraries.index(package)
  end

  def found?(package)
    !!find(package)
  end

  def absent?(package)
    !found?(package)    
  end

end