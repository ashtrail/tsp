require_relative 'utility'

class LKPath
  attr_reader :cost, :path

  def initialize(path, cost)
    @path = path
    @cost = cost
  end

  def self.init_graph(graph)
    @@graph = graph
  end

  # enumerates the path except for the last two nodes
  # because it is useless to apply the minimize logic onto them
  def each()
    @path.each do |node_id|
      unless (node_id == @path.last or node_id == path[-2])
        yield node_id 
      end
    end
  end

  def last()
    @path.last
  end

  # just for syntaxic sugar and logic flow
  def next(node)
    @path[@path.index(node) + 1]
  end

  # cuts the path in two halves at edge [node <-> node + 1]
  # creates a new path composed of the first half
  # and the second half but inversed
  # example : [a, b, c, d, e].cut(b) =  [a, b, e, d, c]
  def rearrange(node)
    idx = @path.index(node) + 1
    new_path = @path[0, idx] + @path[idx, @path.length].reverse
    LKPath.new(new_path, @@graph.path_cost(@path))
  end

  # connects the begining and the end the path
  # returns the tour that was generated
  def reunite()
    tour_cost = cost + @@graph.distance(@path.last, @path.first)
    LKTour.new(@path, tour_cost)
  end
end

# =================================================

class LKTour
  attr_reader :cost, :tour

  # takes an array that represents a tour
  def initialize(solution, cost)
    @tour = solution
    @cost = cost
  end

  def self.init_graph(graph)
    @@graph = graph
  end

  # just for syntaxic sugar
  def each()
    @tour.each do |node_id|
      yield node_id
    end
  end

  # cuts the edge [node <-> node + 1] of the tour
  # in order to create a path, and returns it
  def cut(node)
    idx = @tour.index(node) + 1
    path = @tour[idx, @tour.length] + @tour[0, idx]
    LKPath.new(path, @@graph.path_cost(path))
  end

  # transforms the tour into the accepted solution format
  def as_solution()
    idx = @tour.index(0)
    path = @tour[idx, @tour.length] + @tour[0, idx]
    path.push(0)
  end
end

# =================================================

class LKOptimizer

  # takes a path and runs optimisation on it to minimize its tour
  # returns the newly made tour if found, nil otherwise
  def minimize_tour(path, tour)
    max_gain = -1
    best_path = nil
    path.each do |x|
      y = path.next(x)
      gain = @@graph.distance(x, y) - @@graph.distance(x, path.last) 
      if gain > max_gain
        max_gain = gain
        best_path = path.rearrange(x)
      end
    end
    if max_gain > 0
      new_tour = best_path.reunite
      if new_tour.cost < tour.cost
        return new_tour
      end
    end
    return nil
  end

  # takes a tour and runs optimisation on it until a better tour is found
  # returns the new tour if found, nil otherwise
  def optimize_tour(tour, timer, limit)
    new_tour = nil
    tour.each do |edge|
      if timer.ellapsed >= limit
        return nil
      end
      new_tour = minimize_tour(tour.cut(edge), tour)
      unless new_tour.nil?
        return new_tour
      end 
    end
    return nil
  end

  # runs LK optimization until out of time
  def run(solution, cost, graph, timer, limit)
    LKTour.init_graph(graph)
    LKPath.init_graph(graph)
    @@graph = graph
    tour = LKTour.new(solution, cost)
    while timer.ellapsed < limit
      new_tour = optimize_tour(tour, timer, limit)
      unless new_tour.nil?
        tour = new_tour
      end
    end
    return tour.as_solution
  end

  # runs LK optimization once
  def run_once(solution, cost, graph)
    LKTour.init_graph(graph)
    LKPath.init_graph(graph)
    @@graph = graph
    tour = LKTour.new(solution, cost)
    while timer.ellapsed < limit
      new_tour = optimize_tour(tour, timer, limit)
      unless new_tour.nil?
        return new_tour.as_solution
      end
    end
    return tour.as_solution
  end
end
