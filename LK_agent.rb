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

# parse file
begin
  graph = Parser.new.parse_file(ARGV[0])
  output = File.new(ARGV[1], "w")
rescue
  puts "Usage : ./optimizer_agent.rb input_file output_file."
  exit
end

# greedy solve
solution = solver.solve(graph)

# optimization
deadline = total_time - safety_time
solution.pop
solution = lk.run(solution, solver.cost, graph, time, deadline)

# prints the solution in the output file
output.print "#{Utility.solution_to_s(solution)}"
output.close

puts "#{(time.ellapsed)}"
