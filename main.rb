#!/usr/bin/env ruby

class DoNothing
  def method_missing(m, *args, &block)
    puts "#{m} #{args} #{block}"
  end
end

dog = DoNothing.new
dog.wow
dog.walk_to 'GuangZhou'
dog.sleep do
  puts "Hi"
end



