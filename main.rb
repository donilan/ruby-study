#!/usr/bin/env ruby
$:.unshift File.dirname(__FILE__)
module A
  puts "Loading module A"
  autoload :B, 'a/b'
  puts "Loaded module A"
end

A
A::B.new
