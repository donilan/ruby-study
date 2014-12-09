#!/usr/bin/env ruby


Struct1 = Struct.new :prop1, :prop2
struct1_array = []
100000.times { |n| struct1_array << Struct1.new("prop1 #{n}", n)}
puts "Struct1 array size is: #{Marshal.dump(struct1_array).size}"
