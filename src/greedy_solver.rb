require_relative 'graph'
require_relative 'greedy_tree'

# for each city finds the nearest neighbor
class GreedySolver
  attr_reader :cost

  def initialize()
    @visited_nodes = []
    @cost = 0
  end

  def get_unvisited_nodes(node_edges)
    unvisited_nodes = node_edges.dup
    @visited_nodes.each {|idx| unvisited_nodes.delete(idx)}
    unvisited_nodes
  end

  def get_next_node(curr_node, graph)
    unvisited_nodes = get_unvisited_nodes(curr_node.edges)
    # get nearest neighbor
    closest_neighbor = unvisited_nodes.min_by {|id, distance| distance}
    next_node_id = closest_neighbor[0]
    @visited_nodes.push(next_node_id)
    graph.get_node(next_node_id)
  end

  def solve(graph)
    curr_node = graph.get_node(0)
    @visited_nodes.push(0)

    (graph.size - 1).times do
      curr_node = get_next_node(curr_node, graph)
    end

    @visited_nodes.push(0)
    @visited_nodes
  end
end
