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

  def distance(id, id2)
    @graph[id].edges[id2]
  end

  def path_cost(array)
    last_node = 0
    curr_node = 0
    cost = 0
    array.size.times do |i|
      curr_node = array[i]
      unless i == 0
        cost += distance(last_node, curr_node)
      end
      last_node = curr_node
    end
    cost    
  end

  def tour_cost(array)
    path_cost(array) + distance(array.last, array.first)    
  end

  # @return [Array<Node>]
  def to_a
    @graph
  end
end