#!/usr/bin/env ruby

require './parser'
require './greedy_solver'
require './random_solver'
require './solution_optimizer'


graph = Parser.new.parse_file($*.first)

solver = RandomSolver.new(graph)

output = File.new($*[1], "w")

start_time = Time.now

solver.solve

puts "original cost #{Utility.compute_cost(graph, solver.solution)}"

optimizer = SolutionOptimizer.new(graph, solver.solution)

solution = optimizer.two_opt()

#print "la belle solution c'est #{solution}\n"

output.print "#{Utility.solution_to_s(solution)}"

output.close

print "time : #{(Time.now - start_time).round(3)}\ncost : #{Utility.compute_cost(graph, solution)}\n"
