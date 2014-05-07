#!/usr/bin/env ruby

class TestClass
  def value
    @value ||= []
  end
end

t = TestClass.new
t.value << 1
t.value << 2

p t
p t.value
