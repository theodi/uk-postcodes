Given(/^there are the following postcodes:$/) do |table|
  table.raw.each do |row|
    Postcode.create(
        :postcode => row[0],
        :latlng   => "POINT(#{row[1]} #{row[2]})"
      )
  end
end

Given(/^I make a request for postcodes within (\d+) mile of "(.*?)"$/) do |miles, postcode|
  #UKPostcode.should_receive(:new).and_return(postcode)
  UKPostcode.any_instance.stub(:norm).and_return(postcode)
  visit("/postcode/nearest?miles=#{miles}&postcode=#{URI::escape(postcode)}")
end

Then(/^I should see (\d+) postcodes$/) do |num|
  page.all('#main ul li').count.should == num.to_i
end

Then(/^I should see the following postcodes:$/) do |table|
  table.raw.each do |postcode|
    expect(page).to have_content postcode[0]
  end
end