require 'rubygems'
require 'selenium-webdriver'

$driver = Selenium::WebDriver::Driver.for :chrome
$driver.manage.timeouts.implicit_wait = 3
$driver.manage.window.maximize

