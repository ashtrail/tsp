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

  def get_distance(point, neighbors)
    # puts "neighbors : #{neighbors}\npoint : #{point}\n"
    # puts "dist1 #{@graph.get_node(neighbors[0]).edges[point]}"
    # print "dist2 #{@graph.get_node(point).edges[neighbors[1]]}\n\n"
    return @graph.get_node(neighbors[0]).edges[point] + @graph.get_node(point).edges[neighbors[1]]
  end

  def switch_worth_it?(solution, i, j)
    i_id = solution[i]
    j_id = solution[j]

    if i != 0 and i != (solution.size - 1)
      neighbors1 = [solution[i - 1], solution[i + 1]]
    elsif i == 0
      # puts "prout prout"
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

    # puts "i #{i}, j #{j}"
    # puts "i id #{i_id}, j id #{j_id}"
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
