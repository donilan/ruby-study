#!/usr/bin/env ruby

class SomeClass

  attr_accessor :field1
  
  def method1
    self.field1 = 1
  end

  def method2
    field1 = 2
  end

  def method3
    @field1 = 3
  end

end

s1 = SomeClass.new
s1.method1
puts "After method1 #{s1.field1}."
s1.method2
puts "After method2 #{s1.field1}."
s1.method3
puts "After method3 #{s1.field1}."


