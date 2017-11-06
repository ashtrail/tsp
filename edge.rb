class Edge
  attr_reader :connected_edges

  def initialize(edge_id)
    @id = edge_id
    @connected_edges = {}
  end

  def add_connected_edge(edge, distance)
    @connected_edges[edge] = distance
  end
end