require './utility'

# for each city finds the nearest neighbor
class SolutionOptimizer
    attr_reader :solution

  def initialize(graph, solution)
    @graph = graph
    @solution = solution.dup
    @solution.shift
    @solution.pop
    @size = @solution.size
  end


  def compute_distance(i, j)
    res = @graph.get_node(solution[i]).edges[solution[j]]
    return res
  end

  # def two_opt_alternative()
  #   improved = true
  #   while improved
  #     improved = false
  #     for i in 0..(@size - 1)
  #       for j in 0..@size - 1)
  #         if j == i or j == i + 1 or j == i - 1
  #           next
  #         end
  #         if compute_distance(i, i + 1) + compute_distance(j, j + 1) > compute_distance(i, j) + compute_distance(i + 1, j + 1) 
  #           @solution[i], @solution[j] = @solution[j], @solution[i]
  #           improved = true
  #         end 
  #       end
  #     end
  #   end
  #   @solution
  # end

  def two_opt()
    best_cost = Utility.compute_cost(@graph, @solution)
    (@size - 1).times do |i|
      for k in (i + 1)..(@size - 1)
        new_path = @solution.dup
        new_path[i], new_path[k] = new_path[k], new_path[i]
        new_cost = Utility.compute_cost(@graph, new_path)
        if (new_cost < best_cost)
          @solution = new_path
          best_cost = new_cost
        end  
      end
    end
    solution.unshift(0)
    solution.push(0)
    @solution
  end
end
