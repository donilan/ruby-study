#!/usr/bin/env ruby

def result arg
  if arg == 1
    1
  end

  if arg == 2
    2
  end

  if arg == 3

  end
end

puts "1:#{result 1} 2:#{result 2} 3:#{result 3} 4:#{result 4}"

if result 1
  puts "Result 1"
end
if result 2
  puts "Result 2"
end
if result 3
  puts "Result 3"
end
if result 4
  puts "Result 4"
end



def result2? arg
  case 1
  when 1
    if arg == 1
      1
    end

    if arg == 2
      2
    end

    if arg == 3

    end
  end
end

puts "1:#{result2? 1} 2:#{result2? 2} 3:#{result2? 3} 4:#{result2? 4}"

if result2? 1
  puts "Result2? 1"
end
if result2? 2
  puts "Result2? 2"
end
if result2? 3
  puts "Result2? 3"
end
if result2? 4
  puts "Result2? 4"
end

class Result
  
  attr_accessor :value

  def result?
    if value == 1
      1
    end
    if value == 2
      2
    end

  end

  def to_s
    "#{value}:#{result?}"
  end
end

r = Result.new
r.value = 1
puts "#{r}"
r.value = 2
puts "#{r}"
r.value = 3
puts "#{r}"
