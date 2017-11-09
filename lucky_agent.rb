#!/usr/bin/env ruby

require_relative 'src/parser'
require_relative 'src/random_solver'
require_relative 'src/solution_optimizer'
require_relative 'src/timer'

# init
time = Timer.new
time.start()

solver = RandomSolver.new
optimizer = SolutionOptimizer.new

solution = []

time.save("init")

# parse file
begin
  graph = Parser.new.parse_file(ARGV[0])
  output = File.new(ARGV[1], "w")
rescue => error
  puts "Usage : ./lucky_agent.rb input_file output_file."
  puts error
  exit
end

time.save("parsing")

# random solve loop until 20 seconds
solution = solver.solve(graph)
best_cost = Utility.compute_cost(graph, solution)
while time.ellapsed < 20 do
  tmp_solution = solver.solve(graph)
  tmp_cost = Utility.compute_cost(graph, tmp_solution)
  if tmp_cost < best_cost
    best_cost = tmp_cost
    solution = tmp_solution
  end
end

puts "best cost = #{best_cost}"
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
