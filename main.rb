#!/usr/bin/env ruby

require './parser'
require './greedy_solver'
require './random_solver'


solver = RandomSolver.new(Parser.new.parse_file($*.first))

output = File.new($*[1], "w")

start_time = Time.now

solver.solve

output.print "#{solver.get_path}"

output.close

print "time : #{(Time.now - start_time).round(3)}\ncost : #{solver.get_cost()}\n"
