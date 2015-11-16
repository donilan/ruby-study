#!/usr/bin/env ruby
require 'forwardable'

class A
  attr_reader :field_1, :field_2
  def initialize
    @field_1 = 1
    @field_2 = 2
  end
end

class B
  extend Forwardable
  attr_reader :a
  def_delegators :a, :field_1, :field_2
  @field_3 = 3
  @@field_4 = 4
  def self.field_3
    @field_3
  end
  def self.field_4
    @@field_4
  end
  def initialize
    @a = A.new
  end
  def field_3
    @field_3
  end
  def field_4
    @@field_4
  end
end

b = B.new
puts b.field_1
puts b.field_2
puts b.field_3
puts b.field_4

puts B.field_3
puts B.field_4
