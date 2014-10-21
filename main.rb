#!/usr/bin/env ruby

class App
  
  def initialize app, number
    @number = number
    @app = app
  end

  def call
    puts "#{@number} bean called"
    @app.call if @app
  end

  def to_s
    "No: #{@number}"
  end
end

apps = []

5.times do |i|
  apps << proc {|app| App.new app, i}
end

app = App.new nil, 'leader'
new_app = apps.reverse.inject(app) { |a, e| e[a]}

require 'pry'
binding.pry

