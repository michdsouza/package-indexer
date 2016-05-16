require 'graph.rb'

describe Graph do
  let(:graph) { Graph.new }

	describe '#add_node' do
    it 'adds a new library' do
      graph.add_from_command('actionmailer')
      expect(graph.nodes).to eq ['actionmailer']
      expect(graph.matrix).to eq [[]]
    end

    context 'mail does not exist' do
      it 'does not add library' do
        expect(graph.add_from_command('actionmailer', ['mail'])).to eq false
        expect(graph.nodes).to eq []
      end
    end

    context 'mail exists' do
      before(:each) do
        graph.add_from_command('mail')
      end

      it 'adds a library' do
        expect(graph.add_from_command('actionmailer', ['mail'])).to eq true
        expect(graph.nodes).to match_array(['actionmailer', 'mail'])
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
        expect(graph.nodes).to match_array(['actionmailer', 'mail', 'ruby'])
        expect(graph.matrix).to match_array([[], [], [true, true]])
      end
    end
	end

  describe '#dependency?' do
    before(:each) do
      graph.add_from_command('mail')
      graph.add_from_command('actionmailer', ['mail'])
    end

    it 'checks if node can be removed' do
      expect(graph.dependency?('mail')).to eq true
      expect(graph.dependency?('actionmailer')).to eq false
    end
  end

  describe '#remove_node' do
    before(:each) do
      graph.nodes = ['mail', 'actionmailer', 'ruby']
      graph.matrix = [[true], [true], [nil, nil, true]]
    end

    it 'removes the node from the matrix' do
      graph.remove('actionmailer')
      expect(graph.matrix).to match_array([[true], [nil, true]])
    end

    it 'removes the node from nodes' do
      graph.remove('actionmailer')
      expect(graph.nodes).to match_array(['mail', 'ruby'])
    end 
  end
end