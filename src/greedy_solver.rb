require_relative 'graph'
require_relative 'greedy_tree'

# for each city finds the nearest neighbor
class GreedySolver
  attr_reader :cost

  def initialize()
    @visited_nodes = []
    @cost = 0
    @solution = []
  end

  def get_unvisited_nodes(node_edges)
    unvisited_nodes = node_edges.dup

    @visited_nodes.each {|idx| unvisited_nodes.delete(idx)}

    unvisited_nodes
  end

  def solve(graph)
    size = graph.size
    curr_node = graph.get_node(0)
    @visited_nodes = [0]
    (size - 1).times do |i|
      unvisited_nodes = get_unvisited_nodes(curr_node.edges)
      # get nearest neighbor
      closest_neighbor = unvisited_nodes.min_by {|id, distance| distance}
      next_node_id = closest_neighbor[0]
      @cost += curr_node.edges[next_node_id]
      @visited_nodes.push(next_node_id)
      curr_node = graph.get_node(next_node_id)
    end
    @cost += curr_node.edges[0]
    @visited_nodes.push(0)
    @solution = @visited_nodes
  end

  def comprehensive_solve(graph)
    # init
    solve_tree = GreedyNode.new(nil, 0, 0)
    size = graph.size
    nb_node = 0
    branching = 0
    curr_nodes = []
    curr_nodes << solve_tree

    # generating solution tree
    (size - 1).times do |depth|
      next_nodes = []
      puts "depth #{depth}, branching #{branching}" 
      # for each node of the current depth
      # find all closest neighbors and add them to the tree
        # print "[ "
        # curr_nodes.each do |node|
        #   print ", #{node}"
        # end
        # print " ]\n"
      # curr_nodes.each { |elem| print " #{elem} //"} ; puts ""
      for curr_node in curr_nodes do
        @visited_nodes = curr_node.backtrack
        # @visited_nodes.each { |elem| print " #{elem}"} ; puts ""
        unvisited_nodes = get_unvisited_nodes(graph.get_node(curr_node.id).edges)
        # unvisited_nodes.each { |elem| print " #{elem}"} ; puts ""
        # find all the neighbors with the minimal distance to this node
        min_val = unvisited_nodes.min_by {|id, value| value}[1]
        closest_neighbors = []
        unvisited_nodes.each do |id, dist|
          if dist == min_val
            closest_neighbors << {id => dist}
          end
        end
        branching += closest_neighbors.size - 1
        # add all neighbors to the tree
        print "similar " ; closest_neighbors.each { |elem| print " #{elem}"} ; puts ""
        for neighbor in closest_neighbors
            neighbor.each do |id, dist|
              node = GreedyNode.new(curr_node, curr_node.cost + dist, id)
              nb_node += 1
              curr_node.add_child(node)
              next_nodes << node
            end
        end
      end
      # all the children we just added are the new current nodes
      curr_nodes = next_nodes
    end

    #print "#{curr_nodes}"
    # puts curr_nodes
    # connecting all paths to the first node
    for curr_node in curr_nodes
      # puts curr_node
      curr_node.cost += graph.get_node(curr_node.id).edges[0]
    end

    # solve_tree.disp

    # print "last " ; curr_nodes.each { |elem| print " #{elem}"} ; puts ""

    # finding the less costy path
    best_path = curr_nodes.min { |n1, n2| n1.cost <=> n2.cost }
    puts "the best comprehensive greedy cost is #{best_path.cost}"
    puts "with a branching factor of #{branching} and #{nb_node} nodes in total, damn !"
    @solution = best_path.backtrack.push(0)
  end

  def greediest_solve(graph)
    # init
    solve_tree = GreedyNode.new(nil, 0, 0)
    size = graph.size
    nb_node = 0
    total_cost = 0
    branching = 0
    curr_nodes = []
    curr_nodes << solve_tree

    # generating solution tree
    (size - 1).times do |depth|
      next_nodes = []
      # puts "depth #{depth}, branching #{branching}" 
      # for each node of the current depth
      # find all closest neighbors and add them to the tree
      # curr_nodes.each { |elem| print " #{elem} //"} ; puts ""
      min_cost = 100000
      for curr_node in curr_nodes do
        @visited_nodes = curr_node.backtrack
        # @visited_nodes.each { |elem| print " #{elem}"} ; puts ""
        unvisited_nodes = get_unvisited_nodes(graph.get_node(curr_node.id).edges)
        # unvisited_nodes.each { |elem| print " #{elem}"} ; puts ""
        # find all the neighbors with the minimal distance to this node
        min_val = unvisited_nodes.min_by {|id, value| value}[1]
        if min_val > min_cost
          curr_node.nuke
        else
          min_cost = min_val
          closest_neighbors = []
          unvisited_nodes.each do |id, dist|
            if dist == min_val
              closest_neighbors << {id => dist}
            end
          end
          branching += closest_neighbors.size - 1
          # add all neighbors to the tree
          #print "similar " ; closest_neighbors.each { |elem| print " #{elem}"} ; puts ""
          for neighbor in closest_neighbors
              neighbor.each do |id, dist|
                node = GreedyNode.new(curr_node, curr_node.cost + dist, id)
                nb_node += 1
                curr_node.add_child(node)
                next_nodes << node
              end
          end
        end
      end
      total_cost += min_cost
      filtered = []
      # solve_tree.disp
      next_nodes.each do |node|
        if node.cost > total_cost
          node.nuke
        else
          filtered << node
        end
      end
      # all the children we just added are the new current nodes
      curr_nodes = filtered
    end

    #print "#{curr_nodes}"
    # puts curr_nodes
    # connecting all paths to the first node
    for curr_node in curr_nodes
      # puts curr_node
      curr_node.cost += graph.get_node(curr_node.id).edges[0]
    end

    # solve_tree.disp

    # print "last " ; curr_nodes.each { |elem| print " #{elem}"} ; puts ""

    # finding the less costy path
    best_path = curr_nodes.min { |n1, n2| n1.cost <=> n2.cost }
    puts "the best comprehensive greedy cost is #{best_path.cost}"
    puts "with a branching factor of #{branching} and #{nb_node} nodes in total, damn !"
    @solution = best_path.backtrack.push(0)
  end

end
