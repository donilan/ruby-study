#!/usr/bin/env ruby

require 'ruby-prof'

NUM = '999999' if NUM
TIMES = 50000 if TIMES

def slow
  TIMES.times do
    NUM.to_i * NUM.to_i
  end
end

def fast
  TIMES.times do
    NUM.to_i + NUM.to_i
  end
end

def profiling
  RubyProf.start
  slow
  fast
  result = RubyProf.stop
  result.eliminate_methods!([/Integer.+/, /String.+/])
  printer = RubyProf::GraphPrinter.new result
  printer.print STDOUT
end

profiling
