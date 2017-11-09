require_relative 'utility'

# for each city finds the nearest neighbor
class SolutionOptimizer

  def init(graph, solution)
    @graph = graph
    @solution = Utility.strip(solution)
    @size = @solution.size
  end

  # def compute_distance(i, j)
  #   res = @graph.get_node(@solution[i]).edges[@solution[j]]
  #   return res
  # end

  # def two_opt()
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

  def two_opt(timer, limit)
    best_cost = Utility.compute_cost(@graph, Utility.reformat(@solution))
    (@size - 1).times do |i|
      for j in (i + 1)..(@size - 1)
        if (timer.ellapsed >= limit)
          return Utility.reformat(@solution)
        end

        new_path = @solution.dup
        new_path[i], new_path[j] = new_path[j], new_path[i]
        new_cost = Utility.compute_cost(@graph, Utility.reformat(new_path))
        if (new_cost < best_cost)
          @solution = new_path
          best_cost = new_cost
        end  
      end
    end
    Utility.reformat(@solution)
  end
end
