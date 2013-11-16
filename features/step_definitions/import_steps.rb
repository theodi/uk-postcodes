Given(/^I want to import postcodes from "(.*?)\/(.*?)"$/) do |folder, file|  
  Import.stub(:postcode_path) { Rails.root.join('features', folder, file) }
end

When(/^I run the postcode import task$/) do
  Import.postcodes
end

Then(/^there should be (\d+) postcodes in the database$/) do |num|
  expect(Postcode.count).to be(num.to_i)
end

Given(/^I run the code import tasks$/) do
  Import.codes
  Import.ni_codes
end

Then(/^there should be (\d+) codes in the database$/) do |num|
  expect(Code.count).to be(num.to_i)
end