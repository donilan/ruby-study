#!/usr/bin/env ruby

require 'eventmachine'
require 'em-http-request'

EventMachine.run do
  pool = EventMachine::Pool.new
  spawn = lambda { 
    pool.add EventMachine::HttpRequest.new("http://baidu.com") 
  }
  10.times { spawn[] }

  done, scheduled = 0, 100

  check = lambda do
    done += 1
    if done >= scheduled
      EventMachine.stop
    end
  end

  pool.on_error { |conn| spawn[] }

  100.times do
    pool.perform do |conn|
      req = conn.get :path => '/', :keepalive => true
      req.callback do
        p [:success, conn.object_id, done, req.response.size]
        check[]
      end

      req.errback { check[] }
      req
    end
  end
end

