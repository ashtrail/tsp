require './graph'

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

  def self.solution_to_s(solution)
    str = ""
    solution.each do |elem|
      str += "#{elem + 1}\n"
    end
    str
  end

end