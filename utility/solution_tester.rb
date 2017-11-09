#!/usr/bin/env ruby

# =============================================== # 
# run on a solution file to know if it is correct #
# =============================================== #

class Array
  def subtract_once(values)
    counts = values.inject(Hash.new(0)) { |h, v| h[v] += 1; h }
    reject { |e| counts[e] -= 1 unless counts[e].zero? }
  end
end

def arr_to_s(array)
  str = ""
  for i in 0..(array.size - 1) do
    str += ", " unless i == 0
    str += "#{array[i]}"
  end
  str += "\n"
end

solution = File.readlines($*.first)

# converting each line in an int
solution.map! { |line| line.to_i }

if solution.first != 1 or solution.last != 1
  puts "Error : solution should start and end by 1"
  exit
end

# removing the last 1
solution.pop()

#checking for duplicates
duplicates = solution.subtract_once(solution.uniq)
if !duplicates.empty?
  puts "Error : there should be only one version of each id, duplicates -> #{arr_to_s(duplicates)}"
  exit
end

# checking for invalid ids
id_list = []
for id in 1..solution.size do id_list.push(id) end

too_many = solution.subtract_once(id_list)
not_enough = id_list.subtract_once(solution)

error = false
if !too_many.empty?
  puts "Error : invalid id in solution -> #{arr_to_s(too_many)}"
  error = true
end 
if !not_enough.empty?
  error = true
  puts "Error : some ids are missing -> #{arr_to_s(not_enough)}"
end

if error
  exit
end

# every test were checked
puts "Success : solution is valid !"