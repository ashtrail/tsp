#!/usr/bin/env ruby

require './parser'
require './random_solver'

start_time = Time.now

solver = RandomSolver.new(Parser.new.parse_file($*.first))

output = File.new($*[1], "w")

solver.solve

output.print "#{solver.get_path}"

output.close

print "time : #{(Time.now - start_time).round(3)}\ncost : #{solver.get_cost()}\n"
