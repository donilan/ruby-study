#!/usr/bin/env ruby
require 'byebug'
require 'csv'

class MyCSV < CSV
  attr_reader :origin_lines
  def shift
    @origin_lines ||= {}
    if @_before_lineno != @lineno
      @_before_pos = pos
      @_before_lineno = @lineno
    end
    row = super
    after_pos = pos
    @io.pos = @_before_pos
    @origin_lines[@lineno] = @io.read(after_pos - @_before_pos)
    row
  end
end
csv = MyCSV.new(File.read('./sample.csv'), {headers: true, converters: :numeric, header_converters: :symbol})
csv.each do |row|
  puts "lineno: #{csv.lineno}, content: #{csv.origin_lines[csv.lineno].inspect}"
end
