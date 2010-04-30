Given /^I have sightings at (.+)$/ do |urls|
  urls.split(', ').each do |url|
    url.gsub! /^"|"$/, ''
    Factory.create :sighting, :url => url
  end
end

Then /^I should see a link to "(.+)"$/ do |url|
  assert !find("a[href=#{url.inspect}]").nil?
end
