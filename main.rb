#!/usr/bin/env ruby

require 'vmstat'

puts Vmstat.boot_time
puts Vmstat.memory
puts Vmstat.disk('/')
