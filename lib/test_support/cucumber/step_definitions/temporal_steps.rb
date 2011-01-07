require 'timecop'

Given /it is the year "(.*)"/ do |year|
  Timecop.travel Time.local(year.to_i, 6, 1, 0, 0, 0)
end
