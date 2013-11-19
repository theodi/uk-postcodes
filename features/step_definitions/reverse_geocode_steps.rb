Given(/^I access the latitude and longitude page for "(.*?)"$/) do |latlng|
  visit ("/latlng/#{latlng}")
end

Then(/^I should be redirected to "(.*?)"$/) do |postcode|
  postcode.gsub!(" ", "")
  page.current_path.should eql "/postcode/#{postcode}.html"
end