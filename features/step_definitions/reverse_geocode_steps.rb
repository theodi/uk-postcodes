Given(/^I access the latitude and longitude page for "(.*?)"$/) do |latlng|
  visit ("/latlng/#{latlng}")
end

Then(/^I should be redirected to "(.*?)"$/) do |postcode|
  postcode.gsub!(" ", "")
  page.current_path.should eql "/postcode/#{postcode}.html"
end

Given(/^I request the latitude and longitude page for "(.*?)" in xml format$/) do |latlng|
  visit ("/latlng/#{latlng}.xml")
end

Then(/^I should be redirected to "(.*?)" in xml format$/) do |postcode|
  postcode.gsub!(" ", "")
  page.current_path.should eql "/postcode/#{postcode}.xml"
end
