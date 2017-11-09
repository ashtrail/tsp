require './graph'

# useful static functions used by all the solvers
class Utility

    def self.compute_cost(graph, solution)
    last_node = 0
    curr_node = 0
    cost = 0
    # puts "solution #{solution}"
    solution.size.times do |i|
      curr_node = solution[i]
      if (i > 0)
        # puts "i : #{i}, solution[i] #{solution[i]}"
        # puts "last_node #{last_node}, curr_node #{curr_node}"
        distance = graph.get_node(last_node).edges[curr_node]
        # if (distance.nil?)
        #   puts "i : #{i}, solution[i] #{solution[i]}"
        #   puts "last_node #{last_node}, curr_node #{curr_node}"
        #   print "edges : #{@graph.get_node(last_node).edges}\n\n"          
        # end
        cost += distance
      end
      # puts "last_node #{last_node}, curr_node #{curr_node}"
      last_node = curr_node
      # print "last_node #{last_node}, curr_node #{curr_node}\n\n"
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