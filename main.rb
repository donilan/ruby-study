#!/usr/bin/env ruby

require 'mechanize'
agent = Mechanize.new {|a| 
  # a.ssl_version = 'SSLv3'
  # a.ssl_version = :TLSv1
  a.agent.http.verify_mode = OpenSSL::SSL::VERIFY_NONE
}
page = agent.get("https://gtldresult.icann.org/application-result/applicationstatus/viewstatus")

puts page


