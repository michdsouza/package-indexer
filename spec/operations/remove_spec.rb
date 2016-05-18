require 'graph.rb'
require 'operations/remove.rb'

describe Operations::Remove do
  let(:graph) { Graph.new }
  let(:package) { 'package' }
  let(:dependency) { 'dependency' }

  describe '#remove' do
    before(:each) do 
      graph.libraries = [dependency, package]
      graph.matrix = [[],[true]]
    end

    it 'returns true if package is not indexed' do
      expect(graph.remove('new_package')).to eq true
    end

    it 'returns false if package is a dependency' do
      expect(graph.remove(dependency)).to eq false
    end

    it 'removes package if package is indexed' do
      expect(graph).to receive(:remove_package).with(package)
      graph.remove(package)
    end
  end

  describe '#remove_package' do
    before(:each) { graph.libraries = [package] }

    it 'removes package from matrix' do
      expect(graph).to receive(:remove_from_matrix).with(0)
      graph.remove_package(package)
    end

    it 'removes package from libraries' do
      expect { graph.remove_package(package) }.to change(graph.libraries, :length).by(-1)
    end
  end

  describe '#remove_from_matrix' do
    before(:each) { graph.matrix = [[true, true],[true, true]] }

    it 'removes row from matrix' do
      expect { graph.remove_from_matrix(1) }.to change(graph.matrix, :length).by(-1)
    end

    it 'removes column from matrix' do
      expect { graph.remove_from_matrix(1) }.to change(graph.matrix[0], :length).by(-1)
    end
  end

  describe '#is_dependency?' do
    before(:each) { graph.matrix = [[],[nil, true],[]] }
   
    it 'returns true if package is a dependency' do
      expect(graph.is_dependency?(1)).to eq true
    end

    it 'returns false if package is a dependency' do
      expect(graph.is_dependency?(0)).to eq false
    end
  end
end