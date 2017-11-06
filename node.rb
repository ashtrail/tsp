class Node
  attr_reader :edges

  def initialize(node_id)
    @id = node_id
    @edges = {}
  end

  def add_edge(node_id, distance)
    @edges[node_id] = distance
  end
end