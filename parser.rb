require './graph'

class Parser
  def parseFile(file)
    graph = Graph.new

    File.open(file).readlines.each_with_index do |line, line_index|
      line.split(",").drop(line_index + 1).each_with_index do |distance, edge_index|
        graph.add?(edge_index) if line_index == 0
        graph.add_link(line_index, edge_index, distance) unless line_index == edge_index
      end
    end

    graph
  end
end