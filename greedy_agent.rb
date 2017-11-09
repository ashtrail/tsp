#!/usr/bin/env ruby

require_relative 'src/parser'
require_relative 'src/greedy_solver'
require_relative 'src/solution_optimizer'
require_relative 'src/timer'

# init
time = Timer.new
time.start()

solver = GreedySolver.new
optimizer = SolutionOptimizer.new

solution = []

time.save("init")

# parse file
begin
  graph = Parser.new.parse_file(ARGV[0])
  output = File.new(ARGV[1], "w")
rescue => error
  puts "Usage : ./optimizer_agent.rb input_file output_file."
  puts error
  exit
end

time.save("parsing")

# random solve loop until 20 seconds
solution = solver.solve(graph)
first_cost = Utility.compute_cost(graph, solution)

puts "first cost = #{first_cost}"
time.save("solving")

# optimisation for 5 seconds
optimizer.init(graph, solution)
solution = optimizer.two_opt(time, 25)

time.save("optimization")

# output of the solution
output.print "#{Utility.solution_to_s(solution)}"
output.close

print "time : #{(time.ellapsed)}\ncost : #{Utility.compute_cost(graph, solution)}\n"

time.save("output")

print time.history()
