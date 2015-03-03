#!/usr/bin/env ruby

require 'open3'
require 'pry'

Open3.popen2('echo "please entry a value:"; read a; echo $a') { |i, o, t|

  # binding.pry
  # puts t.pid
  
  # puts t.pending_interrupt?
  # i.write '123'
  # puts t.pending_interrupt?
  # i.close
  # puts t.pending_interrupt?
  puts "pending_interrupt? #{t.pending_interrupt?}"
  puts "alive? #{t.alive?}"
  puts "stop? #{t.stop?}"
  Thread.new {
    binding.pry
  }
  o.each_line do |line|
    puts "line: #{line.inspect}\n"
  end
  # puts t.value
}
