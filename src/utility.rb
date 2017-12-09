require_relative 'graph'

# useful static functions used by all the solvers
class Utility

    def self.compute_cost(graph, solution)
      last_node = 0
      curr_node = 0
      cost = 0
      solution.size.times do |i|
        curr_node = solution[i]
        if (i > 0)
          distance = graph.get_node(last_node).edges[curr_node]
          cost += distance
        end
        last_node = curr_node
      end
      cost
    end

  def self.path_cost(array, graph)
    last_node = 0
    curr_node = 0
    cost = 0
    array.size.times do |i|
      curr_node = array[i]
      unless i == 0
        cost += graph.distance(last_node, curr_node)
      end
      last_node = curr_node
    end
    cost    
  end

  def self.tour_cost(array, graph)
    path_cost(array, graph) + graph.distance(array.last, array.first)    
  end

  def self.solution_to_s(solution)
    str = ""
    solution.each do |elem|
      str += "#{elem + 1}\n"
    end
    str
  end

  def self.strip(solution)
    res = solution.dup
    res.shift()
    res.pop()
    res
  end

  def self.reformat(solution)
    res = solution.dup
    res.unshift(0)
    res.push(0)
    res
  end


end