require './edge'

class Graph
  def initialize
    @graph = []
  end

  def add?(edge_id)
    @graph << Edge.new(edge_id) unless @graph.include? edge_id
  end

  def add_link(edge1, edge2, distance)
    @graph[edge1].add_connected_edge(@graph[edge2], distance)
    @graph[edge2].add_connected_edge(@graph[edge1], distance)
  end

  def size
    @graph.size
  end
end