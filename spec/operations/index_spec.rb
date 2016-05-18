require 'graph.rb'
require 'operations/index.rb'

describe Operations::Index do
  let(:graph) { Graph.new }
  let(:package) { 'package' }
  let(:dependencies) { ['dependency'] }

  describe '#index' do
    context 'package already exists' do
      before(:each) { graph.index('package') }

      subject { graph.index('package') }

      it { expect(subject).to eq true }
      it { expect { subject }.to_not change(graph.libraries, :length) }
    end

    it 'returns false if dependencies are not indexed' do
      expect(graph.index('package', ['dependency'])).to eq false
    end

    it 'adds a new library' do
      graph.index('dependency')
      expect(graph).to receive(:add_package).with('package', ['dependency'])
      graph.index('package', ['dependency'])
    end
  end

  describe '#add_package' do
    before(:each) { graph.index('dependency') }

    it 'adds package to libraries' do
      expect { graph.add_package(package, dependencies) }.to change(graph.libraries, :length).by(1)
    end

    it 'adds dependencies' do
      expect(graph).to receive(:add_dependencies).with(package, dependencies)
      graph.add_package(package, dependencies)
    end
  end

  describe '#add_dependencies' do
    before(:each) do
      graph.index('dependency')
      graph.index('package')
    end

    it 'adds dependency to matrix' do
      expect { graph.add_dependencies(package, dependencies) }.to change(graph.matrix, :length).by(1)
    end
  end

  describe '#dependencies_absent?' do
    it 'returns true if there are dependencies' do
      expect(graph.dependencies_absent?(package, dependencies)).to eq true
    end

    it 'returns false if there are no dependencies' do
      expect(graph.dependencies_absent?(package, [])).to eq false
    end

    it 'returns true if all dependencies are not indexed' do
      graph.libraries = []
      expect(graph.dependencies_absent?(package, dependencies)).to eq true
    end

    it 'returns false if all dependencies are indexed' do
      graph.libraries = ['dependency']
      expect(graph.dependencies_absent?(package, dependencies)).to eq false
    end
  end
end
