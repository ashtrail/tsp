#!/usr/bin/env ruby

# ============================================================= #
# creates an input file argv[0] for tsp problem of size argv[1] #
# ============================================================= #

raise "Usage : ./generate_input.rb nb_nodes nodes_value_range" if ARGV.length != 2  

begin
  size = ARGV[0].to_i
  range = ARGV[1].to_i
rescue 
  puts "Usage : ./generate_input.rb nb_nodes nodes_value_range"
  exit
end

Node = Struct.new(:id, :links)

node_list = Array.new

# generate list once
size.times do |i|
  node = Node.new(i, Array.new)
  node_list.push(node)
end

# connect every node
size.times do |i|
  node = node_list[i]
  size.times do |j|
    if (j == i)
      node.links.push(0)
    elsif (j > i)
      distance = 1 + rand(range)
      node.links.push(distance)
      node_list[j].links.push(distance)
    end
  end
end

# print connections
size.times do |i|
  line = ""
  size.times do |j|
    line += ", " unless j == 0
    line += "#{node_list[i].links[j]}"
  end
  print "#{line}\n"
end
