require './graph'

# finds a random solution for tsp
class RandomSolver
	def initialize(graph)
		@graph = graph
		@size = graph.size
		@visited_nodes = []
		@cost = 0
	end

	def get_unvisited_nodes(node_edges)
		unvisited_nodes = node_edges.keys

		@visited_nodes.each do |idx|
			unvisited_nodes.delete(idx)
		end
		unvisited_nodes
	end

	def solve()
		curr_node = @graph.get_node(0)
		@visited_nodes.push(0)
		(@size - 1).times do |i|
			unvisited_nodes = get_unvisited_nodes(curr_node.edges)
			random_node = rand(unvisited_nodes.size)
			next_node_id = unvisited_nodes[random_node]
			@cost += curr_node.edges[next_node_id]
			@visited_nodes.push(next_node_id)
			curr_node = @graph.get_node(next_node_id)
		end
		@cost += curr_node.edges[0]
		@visited_nodes.push(0)
	end

	def get_path()
		path = ""
		@visited_nodes.each do |elem|
			path += "#{elem + 1}\n"
		end
		path
	end

	def get_cost()
		@cost
	end
end
