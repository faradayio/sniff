require 'time'
require 'timeframe'

Given /^an? (.+) emission$/ do |emitter|
  @emitter_class = emitter.gsub(/\s+/,'_').camelize
  @emitter_class = "#{@emitter_class}Record".constantize
  @activity_hash = {}
  @expectations = []
end

Given /^an? (.+) has nothing$/ do |emitter|
  Given "a #{emitter} emission"
end

Given /^an? (.+) has "(.+)" of "(.*)"$/ do |emitter, field, value|
  Given "a #{emitter} emission"
  Given "it has \"#{field}\" of \"#{value}\""
end

Given /^it has "(.+)" of "(.*)"$/ do |field, value|
  if value =~ /[\d-]+\/[\d-]+/
    @timeframe = Timeframe.interval(value) 
  elsif value.present?
    methods = field.split('.')
    context = @activity_hash
    methods.each do |method|
      method = method.to_sym
      context[method] ||= {}
      value = Date.parse(value) if value =~ /\d{4}-\d{2}-\d{2}/
      context[method] = value if method == methods.last.to_sym
      context = context[method]
    end
  end
end

Given /^the current date is "(.+)"$/ do |current_date|
  @current_date = Time.parse(current_date)
end

When /^emissions are calculated$/ do
  @timeframe ||= Timeframe.this_year
  @activity = @emitter_class.from_params_hash @activity_hash
  @expectations.map(&:call)
  if @current_date
    Timecop.travel(@current_date) do
      @emission = @activity.emission @timeframe
    end
  else
    @emission = @activity.emission @timeframe
  end
  @characteristics = @activity.deliberations[:emission].characteristics
end

Then /^the emission value should be within "([\d\.]+)" kgs of "([\d\.]+)"$/ do |cusion, emissions|
  @emission.should_not be_nil
  @emission.should be_close(emissions.to_f, cusion.to_f)
end

Then /^the calculation should have used committees "(.*)"$/ do |committee_list|
  committees = committee_list.split(/,\s*/)
  committees.each do |committee|
    @characteristics.keys.should include(committee)
  end
end

Then /^the calculation should comply with standards? "(.*)"$/ do |standard_list|
  standards = standard_list.split(/,\s*/)
  This test should pass if the final emission calculation complies with every standard specified
  (this means that every committee that was used complies with every standard specified)
end

Then /^the calculation should not comply with standards? "(.*)"$/ do |standard_list|
  standards = standard_list.split(/,\s*/)
  This test should pass if the final emission calculation does not comply with any of the standards specified
  (this means that at least one committee did not comply with each of the standards specified)
end

Then /^the (.+) committee should be close to "([^,]+)", \+\/-"(.+)"$/ do |committee, value, cusion|
  @characteristics[committee.to_sym].to_f.should be_close(value.to_f, cusion.to_f)
end

Then /^the (.+) committee should be exactly "(.*)"$/ do |committee, value|
  @characteristics[committee.to_sym].to_s.should == value
end

Then /^the active_subtimeframe committee should have timeframe "(.*)"$/ do |tf_string|
  days, start, finish = tf_string.split(/,\s*/)
  @characteristics[:active_subtimeframe].to_s.should =~ /#{days} days starting #{start} ending #{finish}/
end
