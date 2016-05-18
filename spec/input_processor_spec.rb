require 'input_processor.rb'

describe InputProcessor do
  let(:input_processor) { InputProcessor.new }

  describe '#process' do
    it 'returns ERROR when input is invalid' do
      expect(input_processor.process(nil)).to eq "ERROR\n"
    end

    it 'indexes graph when command is INDEX' do
      expect_any_instance_of(Graph).to receive(:index).with('pkg', [])
      input_processor.process("INDEX|pkg|\n")
    end

    it 'removes package when command is REMOVE' do
      expect_any_instance_of(Graph).to receive(:remove)
      input_processor.process("REMOVE|pkg|\n")
    end

    it 'queries package when command is QUERY' do
      expect_any_instance_of(Graph).to receive(:query)
      input_processor.process("QUERY|pkg|\n")
    end

    it 'returns ERROR when command is OTHER' do
      expect(input_processor.process("OTHER|pkg|\n")).to eq "ERROR\n"
    end
  end

  describe '#valid_syntax?' do
    it 'returns false if input is nil' do
      expect(input_processor.valid_syntax?(nil)).to eq false
    end

    it 'returns false if input has extra pipes' do
      expect(input_processor.valid_syntax?('INDEX|pkg|dep|boo|')).to eq false
    end

    it 'returns false if input has too few pipes' do
      expect(input_processor.valid_syntax?('INDEX|pkg dep')).to eq false
    end

    it 'returns true if input is valid' do
      expect(input_processor.valid_syntax?('INDEX|pkg|dep,dep2')).to eq true
    end
  end

  describe '#message' do
    it 'returns OK if result is true' do
      expect(input_processor.message(true)).to eq "OK\n"
    end

    it 'returns FAIL if result is false' do
      expect(input_processor.message(false)).to eq "FAIL\n"
    end
  end

  describe '#to_array' do
    it 'returns empty array if string is nil' do
      expect(input_processor.to_array(nil)).to eq []
    end

    it 'returns array if string is not nil' do
      expect(input_processor.to_array('pkg1,pkg2,pkg3')).to match_array(%w(pkg1 pkg2 pkg3))
    end
  end
end
