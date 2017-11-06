#!/usr/bin/env ruby

require './random_solver'

#Parser.new.parse_file($*.first).check_graph

solver = RandomSolver.new(Parser.new.parse_file($*.first))

print "#{solver.solve()}\n"

puts solver.get_cost()
