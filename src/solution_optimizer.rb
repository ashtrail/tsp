require_relative 'utility'

# for each city finds the nearest neighbor
class SolutionOptimizer

  def init(graph, solution)
    @graph = graph
    @solution = Utility.strip(solution)
    @size = @solution.size
  end

  def get_distance(point, neighbors)
    return @graph.get_node(neighbors[0]).edges[point] + @graph.get_node(point).edges[neighbors[1]]
  end

  def switch_worth_it?(solution, i, j)
    i_id = solution[i]
    j_id = solution[j]

    if i != 0 and i != (solution.size - 1)
      neighbors1 = [solution[i - 1], solution[i + 1]]
    elsif i == 0
      neighbors1 = [0, solution[i + 1]]
    else
      neighbors1 = [solution[i - 1], 0]
    end

    if j != 0 and j != (solution.size - 1)
      neighbors2 = [solution[j - 1], solution[j + 1]]
    elsif j == 0
      neighbors2 = [0, solution[j + 1]]
    else
      neighbors2 = [solution[j - 1], 0]
    end

    return (get_distance(i_id , neighbors1) + get_distance(j_id , neighbors2) > get_distance(j_id , neighbors1) + get_distance(i_id , neighbors2))
  end

  # way more optimised
  def two_opt(timer, limit)
    improved = true
    while improved do
      improved = false
      (@size - 1).times do |i|
        for j in (i + 1)..(@size - 1)
          if (timer.ellapsed >= limit)
            return Utility.reformat(@solution)
          end
          if j != i + 1 and j != i - 1
            if switch_worth_it?(@solution, i, j)
              @solution[i], @solution[j] = @solution[j], @solution[i]
              improved = true
            end
          end  
        end
      end
    end
    Utility.reformat(@solution)
  end

  # way less optimised
  def old(timer, limit)
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
