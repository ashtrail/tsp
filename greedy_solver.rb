require './graph'

# for each city finds the nearest neighbor
class GreedySolver
  def initialize(graph)
    @graph = graph
    @size = graph.size
    @visited_nodes = []
    @cost = 0
    @solution = []
  end

  def get_unvisited_nodes(node_edges)
    unvisited_nodes = node_edges

    @visited_nodes.each {|idx| unvisited_nodes.delete(idx)}

    unvisited_nodes
  end

  def solve()
    curr_node = @graph.get_node(0)
    @visited_nodes.push(0)
    (@size - 1).times do |i|
      unvisited_nodes = get_unvisited_nodes(curr_node.edges)
      # get nearest neighbor 
      closest_neighbor = unvisited_nodes.min_by {|id, distance| distance}
      next_node_id = closest_neighbor[0]
      @cost += curr_node.edges[next_node_id]
      @visited_nodes.push(next_node_id)
      curr_node = @graph.get_node(next_node_id)
    end
    @cost += curr_node.edges[0]
    @visited_nodes.push(0)
    @solution = @visited_nodes
  end

  def get_path()
    path = ""
    @solution.each do |elem|
      path += "#{elem + 1}\n"
    end
    path
  end

  def get_cost()
    @cost
  end

end
