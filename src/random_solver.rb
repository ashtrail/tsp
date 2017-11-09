require_relative 'graph'

# finds a random solution for tsp
class RandomSolver

  def solve(graph)
    solution = graph.get_node(0).edges.keys.shuffle
    solution.unshift(0)
    solution.push(0)
    solution
  end

end
