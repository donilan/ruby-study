#!/usr/bin/env ruby

require 'objspace'
class Integer
  def to_filesize
    {
      'B'  => 1024,
      'KB' => 1024 * 1024,
      'MB' => 1024 * 1024 * 1024,
      'GB' => 1024 * 1024 * 1024 * 1024,
      'TB' => 1024 * 1024 * 1024 * 1024 * 1024
    }.each_pair { |e, s| return "#{(self.to_f / (s / 1024)).round(2)}#{e}" if self < s }
  end
end

GC.start
puts "\n=============="
# puts "Array count: #{ObjectSpace.each_object(Array).count} [#{ObjectSpace.each_object(Array).collect{|a| a.to_s}.join(', ')}]"
# puts "Hash: #{ObjectSpace.each_object(Hash).count} [#{ObjectSpace.each_object(Hash).collect{|a| a.to_s}.join(', ')}] "
puts "String size: #{ObjectSpace.memsize_of(String).to_filesize}"
puts "String: #{ObjectSpace.each_object(String).count}\tmemorys: #{ObjectSpace.each_object(String).collect{|a| ObjectSpace.memsize_of a}.inject(:+).to_filesize}"
puts "#{ObjectSpace.count_tdata_objects}"
puts "#{ObjectSpace.count_objects}"
puts "Numeric: #{ObjectSpace.each_object(Numeric).count}\tmemorys: #{ObjectSpace.each_object(Numeric).collect{|a| ObjectSpace.memsize_of a}.inject(:+).to_filesize}"

total = 0
mem_hash = {}
ObjectSpace.each_object { |o|
  s = ObjectSpace.memsize_of o
  if s > 0
    mem_hash[o.class] ||= 0
    mem_hash[o.class] += s
    total += s
  end
}
puts "total: #{total.to_filesize}"
showable = mem_hash.select {|k, v| v > 1024*512}
puts "#{showable.sort_by{|k,v| v}.collect {|k, v| "%-50s: %s" % [k, v.to_filesize] }.join("\n")}"
## end test
