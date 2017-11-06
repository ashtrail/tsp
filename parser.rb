require './graph'

class Parser

  def parse_file(file)
    graph = Graph.new

    lines = File.open(file).readlines
    lines.size.times {|i| graph.add i}

    lines.each_with_index do |line, line_index|
      line.split(",").drop(line_index + 1).each_with_index do |distance, index|
        graph.add_link(line_index, line_index + 1 + index, distance.to_i)
      end
    end

    graph
  end

end