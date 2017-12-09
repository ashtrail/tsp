class TabuSolver
  # @param [Graph] graph
  def random_permutation(graph)
    perm = Array.new(graph.size) {|i| i}
    perm.shift

    perm.each_index do |i|
      r = rand(perm.size - i) + i
      perm[r], perm[i] = perm[i], perm[r]
    end

    # perm.shuffle!
    perm.unshift(0)
    perm
  end

  def stochastic_two_opt(parent)
    perm = Array.new(parent)
    c1, c2 = rand(perm.size), rand(perm.size)

    exclude = [c1]
    exclude << ((c1 == 0) ? perm.size - 1 : c1 - 1)
    exclude << ((c1 == perm.size - 1) ? 0 : c1 + 1)

    c2 = rand(perm.size) while exclude.include?(c2)
    c1, c2 = c2, c1 if c2 < c1
    perm[c1...c2] = perm[c1...c2].reverse

    [perm, [[parent[c1 - 1], parent[c1]], [parent[c2 - 1], parent[c2]]]]
  end

  def is_tabu?(permutation, tabu_list)
    permutation.each_with_index do |c1, i|
      c2 = (i == permutation.size - 1) ? permutation[0] : permutation[i + 1]
      tabu_list.each do |forbidden_edge|
        return true if forbidden_edge == [c1, c2]
      end
    end
    false
  end

  def generate_candidates(best, tabu_list, graph)
    perm, nodes = nil, nil

    vector = Utility.strip(best[:vector])
    begin
      perm, nodes = stochastic_two_opt(vector)
    end while is_tabu?(perm, tabu_list)

    candidate = {:vector => Utility.reformat(perm)}
    candidate[:cost] = Utility.compute_cost(graph, candidate[:vector])

    [candidate, nodes]
  end

# @param [Graph] graph
# @param [Integer] tabu_list_size
# @param [Integer] max_candidates
# @param [Integer] max_iter
  def search(graph, best, timer, deadline, tabu_list_size, max_candidates)
    current = {:vector => best}
    current[:cost] = Utility.compute_cost(graph, current[:vector])
    best = current
    tabu_list = Array.new(tabu_list_size)
    while timer.ellapsed <= deadline do
      candidates = Array.new(max_candidates) do
        generate_candidates(current, tabu_list, graph)
      end
      candidates.sort! {|x, y| x.first[:cost] <=> y.first[:cost]}
      best_candidate = candidates.first[0]
      best_candidate_edges = candidates.first[1]
      if best_candidate[:cost] < current[:cost]
        current = best_candidate
        best = best_candidate if best_candidate[:cost] < best[:cost]
        best_candidate_edges.each {|edge| tabu_list.push(edge)}
        tabu_list.pop while tabu_list.size > tabu_list_size
      end
      #puts " > iteration #{(iter + 1)}, best=#{best[:cost]}"
    end
    best[:vector]
  end

  def solve(graph, best, timer, deadline)
    tabu_list_size = 15
    max_candidates = graph.size

    search(graph, best, timer, deadline, tabu_list_size, max_candidates)
  end
end