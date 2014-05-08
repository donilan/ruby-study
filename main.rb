#!/usr/bin/env ruby

lamb = lambda {|a, b, c| a + b + c}

p lamb[1, 2, 3]
p lamb.(1, 2, 3)
p lamb.call 1, 2, 3
