#!/usr/bin/env ruby

def after(name)
  m = instance_method(name)
  define_method(name) do |*args, &block|
    m.bind(self).(*args, &block)
    yield @array
  end
end

class TestClass
  
  attr_accessor :name

  def test
    @array ||= []
    print "Method test called. array #{@array}\n"
  end

  def send
    print "Method call called.\n"
  end
end

TestClass
class TestClass
  after(:test) { |array|
    p @array
    array << 1
    print "New test method called.\n"
  }
end


t = TestClass.new
t.test
t.test
