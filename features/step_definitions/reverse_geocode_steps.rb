Given(/^I access the latitude and longitude page for "(.*?)"$/) do |latlng|
  visit ("/latlng/#{latlng}")
end

Then(/^I should be redirected to "(.*?)"$/) do |postcode|
  postcode.gsub!(" ", "")
  page.current_path.should eql "/postcode/#{postcode}.html"
end

Given(/^I request the latitude and longitude page for "(.*?)" in (.*?) format$/) do |latlng, format|
  visit ("/latlng/#{latlng}.#{format}")
end

Then(/^I should be redirected to "(.*?)" in (.*?) format$/) do |postcode, format|
  postcode.gsub!(" ", "")
  page.current_path.should eql "/postcode/#{postcode}.#{format}"
end
