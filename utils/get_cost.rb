#!/usr/bin/env ruby

require_relative '../src/parser'
require_relative '../src/utility'

#parse file
begin
  graph = Parser.new.parse_file(ARGV[0])
  lines = File.open(ARGV[1]).readlines
  solution = []
  lines.each do |id|
    solution.push(id.to_i - 1)
  end
rescue
  puts "Usage : ./get_cost.rb graph solution."
  exit
end

# prints the solution in the output file
puts "#{Utility.compute_cost(graph, solution)}"

