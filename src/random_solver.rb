require_relative 'graph'
require_relative 'utility'

# finds a random solution for tsp
class RandomSolver

  def solve(graph)
    solution = graph.get_node(0).edges.keys.shuffle
    Utility.reformat(solution)
  end

end
