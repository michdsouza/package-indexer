require 'graph.rb'

describe Graph do
  let(:graph) { Graph.new }

 describe '#index' do
    it 'adds a new library' do
      graph.index('actionmailer')
      expect(graph.libraries).to eq ['actionmailer']
      expect(graph.matrix).to eq [[]]
    end

    it 'does not add library if dependency does not exist' do
      expect(graph.index('actionmailer', ['mail'])).to eq false
      expect(graph.libraries).to eq []
    end

    context 'dependency exists' do
      before(:each) do
        graph.index('mail')
      end

      it 'adds the library' do
        expect(graph.index('actionmailer', ['mail'])).to eq true
        expect(graph.libraries).to match_array(['actionmailer', 'mail'])
        expect(graph.matrix).to match_array([[],[true]])
      end

    end

    context 'multiple dependencies exist' do
      before(:each) do
        graph.index('mail')
        graph.index('ruby')
      end

      it 'adds the library' do
        expect(graph.index('actionmailer', ['mail', 'ruby'])).to eq true
        expect(graph.libraries).to match_array(['actionmailer', 'mail', 'ruby'])
        expect(graph.matrix).to match_array([[], [], [true, true]])
      end
    end
  end

  describe '#remove' do
    before(:each) do
      graph.libraries = ['mail', 'actionmailer', 'ruby']
      graph.matrix = [[true], [true], [nil, nil, true]]
    end

    context 'when library can be removed' do
      it 'removes the library from the matrix' do
        graph.remove('actionmailer')
        expect(graph.matrix).to match_array([[true], [nil, true]])
      end

      it 'removes the library from libraries' do
        graph.remove('actionmailer')
        expect(graph.libraries).to match_array(['mail', 'ruby'])
      end 
    end

    context 'when library was not indexed' do
      it 'returns true' do
        expect(graph.remove('something')).to eq true
      end 
    end
  end

  describe '#query' do
    it 'returns true if library exists' do
      graph.add('actionmailer')
      expect(graph.query('actionmailer')).to eq true
    end

    it 'returns false if library does not exist' do
      expect(graph.query('actionmailer')).to eq false
    end
  end

  describe '#add_dependencies' do
    before(:each) do
      graph.add('first_dependency')
      graph.add('second_dependency')
      graph.add('package')
    end

    it 'adds dependency to matrix' do
      graph.add_dependencies(2, ['first_dependency', 'second_dependency'])
      expect(graph.matrix).to eq [[], [], [true, true]]
    end
  end

  describe '#add' do
    before(:each) do
      graph.add('actionmailer')
    end
    
    it 'adds a new library to the list of libraries' do
      expect(graph.libraries).to eq ['actionmailer']
    end
    
    it 'adds a new library to the adjacency matrix' do
      expect(graph.matrix).to eq [[]]
    end
  end

  describe '#find_index' do
    before(:each) do
      graph.add('actionmailer')
    end
    
    it 'returns the index of the library' do
      expect(graph.find_index('actionmailer')).to eq 0
    end
    
    it 'returns nils when library not found' do
      expect(graph.find_index('ruby')).to eq nil
    end
  end

  describe '#dependencies_not_indexed?' do
    it 'returns true if dependencies not indexed' do
      expect(graph.dependencies_not_indexed?('package', ['dependency'])).to eq true
    end

    it 'returns false if dependencies indexed' do
      graph.libraries = ['dependency']
      expect(graph.dependencies_not_indexed?('package', ['dependency'])).to eq false
    end
  end

  describe '#is_a_dependency?' do
    before(:each) do
      graph.libraries = ['mail', 'actionmailer']
      graph.matrix = [[], [true]]
    end

    context 'when library is a dependency' do
      it 'returns true' do
        expect(graph.is_a_dependency?(0)).to eq true
      end
    end

    context 'when library is not a dependency' do
      it 'returns false' do
        expect(graph.is_a_dependency?(1)).to eq false
      end
    end
  end

  

	
  
end