
Given(/^I am on the Home Page$/) do
  $driver.get "http://www.collegeconfidential.com/"
end

When(/^I start searching for a college$/ ) do
  $driver.find_element(:id,"find_a_college_main").click
  expect($driver.current_url).to include("college_search")
end

When(/^I select the Location as "([^"]*)"$/) do |location|
  @wait=Selenium::WebDriver::Wait.new(:timeout =>35)
  # switch to frame element
  frame_element = @wait.until {$driver.find_element(:id, 'supermatch')} 
  $driver.switch_to.frame  frame_element
  
  #clcik on location filter and select desired location
  $driver.find_element(:id, "critHeader0").click 
  new_xpath = ".//*[@id='locationCriteria']/div/div/div[2]//span[.='#{location}']"
  puts new_xpath
  location_value = $driver.find_element(:xpath, new_xpath)
  location_value.click
  
  #verify desired location is added
  selected_xpath = ".//div[@class='ui-picklist-option-selected']/span[contains(text(),'#{location}')]"
  selected_location = $driver.find_element(:xpath, new_xpath)
  expect(selected_location).to be_displayed
end

When(/^I select the Majors as "([^"]*)"$/) do |major|
  #select the majors filter
  majors_filter = $driver.find_element(:id, "critHeader1")
  majors_filter.click
  
  #select the degree
  
  #adding sleep to avoid unknown error: Element is not clickable at point (114, 476). Other element
  #would receive the click: <label for="degreeTypeRadio1" class="padded">...</label>
  #which would select the wrong degree
  #Explicit wait didn't help
  sleep 5 
  new_xpath = ".//*[@id='majorCriteria']/label//span[contains(text(),'#{major}')]"
  puts new_xpath
  degree = $driver.find_element(:xpath, new_xpath)
  #expect(degree.displayed?). to be_truthy, "Radio button not displayed"
  degree.click
end

When(/^I enter "([^"]*)" as my preference$/) do |preference|
  #enter the preferred course
  major_search = $driver.find_element(:id, "majorSearchText")
  major_search.send_keys(preference)
  
  #select the preferred course from the matches
  new_xpath = ".//*[@id='matchingMajors']//span[contains(text(),'#{preference}')]"
  puts new_xpath
  match = @wait.until {$driver.find_element(:xpath, new_xpath)}
  match.click
  
  #verify desired degree is added
  selected_xpath = ".//div[@class='ui-picklist-selected-option']/span[contains(text(),'#{preference}')]"
  selected_degree = $driver.find_element(:xpath, new_xpath)
  expect(selected_degree).to be_displayed
end

Then(/^I verify that "([^"]*)" is a (\d+)% match$/) do |college, percentage|
  #verify college name and link
  new_xpath = ".//a[text()='#{college}']"
  result_college = $driver.find_element(:xpath, new_xpath)
  expect(result_college).to be_displayed
  
  #verify percentage match
  complex_xpath = ".//a[text()='Miami University-Oxford']/ancestor::node()[contains(@class,'column3')]//preceding::div[contains(@class,'column1')]//div[@class='percentMatch']"
  percent_match = $driver.find_element(:xpath,complex_xpath)
  expect(percent_match.text).to include(percentage)
end