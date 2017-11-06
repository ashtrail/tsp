require './edge'

class Graph
  def initialize
    @graph = []
  end

  def add?(edge_id)
    @graph << Edge.new(edge_id)
  end

  def add_link(edge1, edge2, distance)
    @graph[edge1].add_connected_edge(edge2, distance)
    @graph[edge2].add_connected_edge(edge1, distance)
  end

  def size
    @graph.size
  end

  def check_graph
    @graph.each do |edge|
      puts edge.connected_edges.size
    end
  end
end