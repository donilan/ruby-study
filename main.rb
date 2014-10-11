#!/usr/bin/env ruby

require 'metriks'

while true
  ran = Random.rand(0.1..1.5).round(2)
  meter = Metriks.meter('requests')
  meter.mark
  puts "#{meter.count} rate: #{meter.one_minute_rate}, #{meter.five_minute_rate}, #{meter.fifteen_minute_rate} ran: #{ran}"
  sleep(ran)
end
