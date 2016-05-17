require 'graph.rb'

describe Graph do
  let(:graph) { Graph.new }

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
    
    context 'when library found' do
      it 'returns the index of the library' do
        expect(graph.find_index('actionmailer')).to eq 0
      end
    end
    
    context 'when library not found' do
      it 'returns nils' do
        expect(graph.find_index('ruby')).to eq nil
      end
    end
  end

  describe '#dependency?' do
    before(:each) do
      graph.libraries = ['mail', 'actionmailer']
      graph.matrix = [[], [true]]
    end

    context 'when library is a dependency' do
      it 'returns true' do
        expect(graph.dependency?(0)).to eq true
      end
    end

    context 'when library is not a dependency' do
      it 'returns false' do
        expect(graph.dependency?(1)).to eq false
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

    context 'when library cannot be removed' do
      it 'returns false' do
        expect(graph.remove('something')).to eq false
      end 
    end
  end

	describe '#add_node' do
    it 'adds a new library' do
      graph.add_from_command('actionmailer')
      expect(graph.libraries).to eq ['actionmailer']
      expect(graph.matrix).to eq [[]]
    end

    context 'mail does not exist' do
      it 'does not add library' do
        expect(graph.add_from_command('actionmailer', ['mail'])).to eq false
        expect(graph.libraries).to eq []
      end
    end

    context 'mail exists' do
      before(:each) do
        graph.add_from_command('mail')
      end

      it 'adds a library' do
        expect(graph.add_from_command('actionmailer', ['mail'])).to eq true
        expect(graph.libraries).to match_array(['actionmailer', 'mail'])
        expect(graph.matrix).to match_array([[],[true]])
      end

    end

    context 'multiple dependencies exist' do
      before(:each) do
        graph.add_from_command('mail')
        graph.add_from_command('ruby')
      end

      it 'adds a library' do
        expect(graph.add_from_command('actionmailer', ['mail', 'ruby'])).to eq true
        expect(graph.libraries).to match_array(['actionmailer', 'mail', 'ruby'])
        expect(graph.matrix).to match_array([[], [], [true, true]])
      end
    end
	end
  
end