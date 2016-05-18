require "graph.rb"

describe Graph do
  let(:graph) { Graph.new }

  describe '#find' do
    before(:each) do
      graph.libraries = ["actionmailer"]
    end

    it "returns the index of the package" do
      expect(graph.find("actionmailer")).to eq 0
    end

    it "returns nils when package not found" do
      expect(graph.find("ruby")).to eq nil
    end
  end

  describe '#found?' do
    before(:each) do
      graph.libraries = ["actionmailer"]
    end

    it "returns true when package is found" do
      expect(graph.found?("actionmailer")).to eq true
    end

    it "returns false when package not found" do
      expect(graph.found?("ruby")).to eq false
    end
  end

  describe '#absent?' do
    before(:each) do
      graph.libraries = ["actionmailer"]
    end

    it "returns false when package is found" do
      expect(graph.absent?("actionmailer")).to eq false
    end

    it "returns true when package not absent" do
      expect(graph.absent?("ruby")).to eq true
    end
  end
end
