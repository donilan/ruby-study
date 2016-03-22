#!/usr/bin/env ruby


# require 'byebug'
# require 'capybara'
# require 'capybara/poltergeist'

# Capybara.javascript_driver = :poltergeist
# # Capybara.default_driver = :selenium

# class Test
#   attr_reader :session

#   def initialize
#     # @session = Capybara::Session.new :selenium #'http://www.google.com'
#     @session = Capybara::Session.new :poltergeist
#   end
#   def run
#     session.visit('https://login.taobao.com')
#     puts session.find(:id, 'J_Form')
#     session.within(:xpath, "//form[@id='J_Form']") do
# session.fill_in 'TPL_username_1', with: ENV['TAOBAO_USERNAME']
# session.fill_in 'TPL_password_1', with: ENV['TAOBAO_PASSWORD']
#     end
#     session.click_button("J_SubmitStatic")
#     session.visit('https://shop1375203226805.1688.com/page/offerlist.htm?pageNum=1')
#     byebug
#     puts "Hello"
#     # `rm login.png`
#     # session.save_screenshot('login.png')
#     # `open login.png`
#     # puts "submitting"
#     # sleep(2)
#     # puts "Done"
#   end
# end

# Test.new.run

require "selenium-webdriver"
driver = Selenium::WebDriver.for(:remote, :url => "http://localhost:4444")
driver.navigate.to "http://google.com"
driver.save_screenshot('test.png')
