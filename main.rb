#!/usr/bin/env ruby

require 'csv'
require 'ruby-prof'

csv = CSV.read('./MOCK_DATA.csv', {headers: true})
rows = []
RubyProf.start
csv.each do |row|
  rows << row.to_h
end
result = RubyProf.stop
printer = RubyProf::FlatPrinter.new(result)
printer.print(STDOUT)

puts "= " * 10

csv = CSV.read('./MOCK_DATA.csv')
rows = []
RubyProf.start
headers = csv.shift
csv.each do |row|
  rows << headers.zip(row).to_h
end
result = RubyProf.stop
puts rows.first
printer = RubyProf::FlatPrinter.new(result)
printer.print(STDOUT)
