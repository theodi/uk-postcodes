Given(/^I access the page for "(.*?)"$/) do |postcode|
  postcode.gsub!(" ", "")
  visit ("/postcode/#{postcode}")
end

Then(/^I should see the following details:$/) do |table|
  table.rows_hash.each do |k,v|
    dd = page.find("dd.#{k}")
    expect(dd).to have_content v
  end
end

Given(/^I access the (.*?) version of "(.*?)"$/) do |format, postcode|
  postcode.gsub!(" ", "")
  visit ("/postcode/#{postcode}.#{format.downcase}")
end

Then(/^I should see the following json:$/) do |string|
  JSON.parse(page.body).should eql(JSON.parse(string.squish))
end

Then(/^I should see the following xml:$/) do |xml|
  page.body.squish.should eql xml.squish
end