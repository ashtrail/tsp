#!/usr/bin/env ruby

require_relative 'src/parser'
require_relative 'src/greedy_solver'
require_relative 'src/LKOptimizer'
require_relative 'src/timer'

# init
total_time = 30
safety_time = 2

time = Timer.new
time.start()

solver = GreedySolver.new
lk = LKOptimizer.new

solution = []

# time.save("init")

# parse file
begin
  graph = Parser.new.parse_file(ARGV[0])
  output = File.new(ARGV[1], "w")
rescue
  puts "Usage : ./optimizer_agent.rb input_file output_file."
  exit
end

# verbose
# time.save("parsing")

# greedy solve
solution = solver.solve(graph)

# verbose
# puts "first cost = #{solver.cost}"
# time.save("solving")

# optimization
deadline = total_time - safety_time
solution.pop
solution = lk.run(solution, solver.cost, graph, time, deadline)

# verbose
# puts "#{solution}"
# puts "optimized cost = #{Utility.compute_cost(graph, solution)}"
# time.save("optimization")

# prints the solution in the output file
output.print "#{Utility.solution_to_s(solution)}"
output.close

puts "#{(time.ellapsed)}"

# verbose
# print "time : #{(time.ellapsed)}\ncost : #{Utility.compute_cost(graph, solution)}\n"
# time.save("output")
# print time.history()
