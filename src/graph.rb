require_relative 'node'

class Graph
  def initialize
    @graph = []
  end

  def add(node_id)
    @graph << Node.new(node_id)
  end

  def add_link(first_node_id, second_node_id, distance)
    @graph[first_node_id].add_edge(second_node_id, distance)
    @graph[second_node_id].add_edge(first_node_id, distance)
  end

  def size
    @graph.size
  end

  def get_node(node_id)
    @graph[node_id]
  end

  # @return [Array<Node>]
  def to_a
    @graph
  end
end