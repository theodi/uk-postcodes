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