require "graph.rb"
require "operations/query.rb"

describe Operations::Query do
  let(:graph) { Graph.new }

  describe '#query' do
    it "returns true if package is found" do
      graph.libraries = ["package"]
      expect(graph.query("package")).to eq true
    end

    it "returns false if package is not found" do
      expect(graph.query("package")).to eq false
    end
  end
end
