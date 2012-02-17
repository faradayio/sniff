require 'time'
require 'timeframe'

Given %r{^an? (\w+)( impact)?$} do |name, _|
  name = name.gsub(/\s+/,'_').camelize + 'Record'
  init_activity name.constantize
end

Given /^(a )?characteristic "(.*)" of integer value "(.*)"$/ do |_, name, value|
  step "characteristic \"#{name}\" of \"#{value}\", converted with \"to_i\""
end
Given /^(a )?characteristic "(.*)" of address value "(.*)"$/ do |_, name, value|
  step "characteristic \"#{name}\" of \"#{value}\", converted with \"to_s\""
end

Given /^(a )?characteristic "(.*)" of "([^\"]*)"(, converted with "(.*)")?$/ do |_, name, value, __, converter|
  if name =~ /\./
    model_name, attribute = name.split /\./
    model = begin
      model_name.singularize.camelize.constantize
    rescue NameError
      association = activity.reflect_on_association model_name.to_sym
      association.klass
    end
    value = model.send "find_by_#{attribute}", value
    characteristics[model_name.to_sym] = value unless value.nil?
  elsif name == 'timeframe' 
    self.timeframe = (value.present?) ? Timeframe.interval(value) : nil
  elsif name == 'active_subtimeframe'
    characteristics[:active_subtimeframe] = (value.present?) ? Timeframe.interval(value) : nil
  elsif converter
    value = value.send converter
    characteristics[name.to_sym] = value unless value.nil?
  else
    value = coerce_value(value)
    characteristics[name.to_sym] = value unless value.nil?
  end
end

Given /^(a )?characteristic "(.*)" including "(.*)"$/ do |_, name, values|
  characteristics[name.to_sym] ||= []
  characteristics[name.to_sym] += values.split(/,/)
end

Given /^an? (.+) has nothing$/ do |emitter|
end

Given /^it has "(.+)" of "(.*)"$/ do |field, value|
  step %Q{characteristic "#{field}" of "#{value}"}
end

When /^impacts are calculated$/ do
  expectations.map(&:call)
  Timecop.travel(current_date || Time.now) do
    self.timeframe ||= Timeframe.this_year
    this.activity_instance = activity.new characteristics
    self.impact = activity_instance.impact timeframe
  end
  characteristics = activity_instance.deliberations[:impact].characteristics
end

Then /^the amount of "(.*)" should be within "([\d\.]+)" of "([\d\.]+)"$/ do |substance, cushion, target|
  impact.should_not be_nil
  impact[substance.to_sym].should be_within(cushion.to_f).of(target.to_f)
end

Then /^the calculation should have used committees "(.*)"$/ do |committee_list|
  committees = committee_list.split(/,\s*/)
  committees.each do |committee|
    characteristics.keys.should include(committee)
  end
end

Then /^the calculation should comply with standards? "(.*)"$/ do |standard_list|
  standards = Set.new standard_list.split(/,\s*/).map(&:to_sym)
  compliance = Set.new activity_instance.deliberations[:impact].compliance
  unless standards.empty?
    compliance.should_not be_empty, 'Expected calculation to comply with some standards, but it complied with none'
  end
  exclusive_list = (compliance ^ standards)
  exclusive_list.should be_empty, "Calculation did not comply with #{(standards - compliance).to_a.inspect})"
end

Then /^the calculation should not comply with standards? "(.*)"$/ do |standard_list|
  standards = Set.new standard_list.split(/,\s*/).map(&:to_sym)
  compliance = Set.new activity_instance.deliberations[:impact].compliance
  unless compliance.empty?
    diff_list = (standards - compliance)  # s - c = set of anything in s that is not in c
    diff_list.should be(standards), "Calculation should not have complied with #{(standards - diff_list).to_a.inspect}"
  end
end

Then /^the (.+) committee should be close to "([^,]+)", \+\/-"(.+)"$/ do |committee, value, cushion|
  characteristics[committee.to_sym].to_f.should be_within(cushion.to_f).of(value.to_f)
end

Then /^the (.+) committee should be exactly "(.*)"$/ do |committee, value|
  characteristics[committee.to_sym].to_s.should == value
end

Then /^the active_subtimeframe committee should have timeframe "(.*)"$/ do |tf_string|
  days, start, finish = tf_string.split(/,\s*/)
  characteristics[:active_subtimeframe].to_s.should =~ /#{days} days starting #{start} ending #{finish}/
end
