require 'active_support'

When /^the "(.*)" committee is calculated$/ do |committee_name|
  @expectations.map(&:call)
  @decision ||= @activity.decisions[:emission]
  @committee = @decision.committees.find { |c| c.name.to_s == committee_name }
  args = [@characteristics]
  if @timeframe
    args << [@timeframe]
  else
    args << []
  end
  @report = @committee.report *args
#  if @report.nil?
#    raise "The committee #{@committee.name} did not come to a conclusion. Characteristics: #{@characteristics.inspect}"
#  else
    @characteristics[committee_name.to_sym] = @report.try(:conclusion)
#  end
end

Then /^then a report should exist for the committee$/ do
  raise "Missing report for committee #{@committee.name}" if @report.nil?
end

Then /^the committee should have used quorum "(.*)"$/ do |quorum|
  Then 'then a report should exist for the committee'
  @report.quorum.name.should == quorum
end

Then /^the conclusion should comply with standards? "(.*)"$/ do |standard_list|
  Then 'then a report should exist for the committee'
  standards = standard_list.split(/,\s*/)
  standards.each do |standard|
    @report.quorum.compliance.map(&:to_s).should include(standard)
  end
end

Then /^the conclusion should not comply with standards? "(.*)"$/ do |standard_list|
  Then 'then a report should exist for the committee'
  standards = standard_list.split(/,\s*/)
  standards.each do |standard|
    @report.quorum.compliance.map(&:to_s).should_not include(standard)
  end
end

Then /^the conclusion of the committee should be "(.*)"$/ do |conclusion|
  compare_values(@report.try(:conclusion), conclusion)
end

Then /^the conclusion of the committee should be timeframe "(.*)"$/ do |conclusion|
  timeframe = Timeframe.interval(conclusion)
  compare_values(@report.try(:conclusion), timeframe)
end

Then /^the conclusion of the committee should be nil$/ do
  compare_values(@report.try(:conclusion), nil)
end

Then /^the conclusion of the committee should include a key of "(.*)" and value "(.*)"$/ do |key, value|
  if key.present?
    @report.conclusion.keys.map(&:to_s).should include(key)
  else
    @report.conclusion.keys.map(&:to_s).should be_blank
  end

  if value.present?
    @report.conclusion.each do |k, v|
      @report.conclusion[k.to_s] == v
    end
    compare_values(@report.conclusion[key.to_s], value)
  end
end

Then /^the conclusion of the committee should have "(.*)" of "(.*)"$/ do |attribute, value|
  report_value = coerce_value @report.conclusion.send(attribute)
  compare_values report_value, value
end

Then /^the conclusion of the committee should include "(.*)"$/ do |value|
  result = @report.conclusion.find do |item|
    equality? item, value
  end
  result.should_not be_nil
end

Then /^the conclusion of the committee should have a( single)? record identified with "(.*)" of "(.*)" and having "(.*)" of "(.*)"$/ do |single, id_field, id, field, value|
  if value.blank?
    @report.conclusion.should be_blank
  else
    id_field = id_field.to_sym
    records = @report.conclusion
    record = records.to_a.find { |r| equality? r.send(id_field), id }
    record.should_not be_nil
    compare_values record.send(field), value
    if single
      records.count.should == 1
    end
  end
end

Then /^the conclusion of the committee should have a record identified with "(.*)" of "(.*)" and having "(.*)" including "(.*)"$/ do |id_field, id, field, values|
  values.split(/,/).each do |value|
    Then "the conclusion of the committee should have a record identified with \"#{id_field}\" of \"#{id}\" and having \"#{field}\" of \"#{value}\""
  end
end

Then /^the conclusion of the committee should have a record with "([^"]*)" equal to "([^"]*)"$/ do |field, value|
  record = @report.conclusion
  compare_values(coerce_value(record.send(field)),value)
end

Then /^the conclusion of the committee should include a key of "(.*)" and subvalue "(.*)" of "(.*)" and subvalue "(.*)" of "(.*)"$/ do |key, subkey1, subvalue1, subkey2, subvalue2|
  if key.present?
    @report.conclusion.keys.map(&:to_s).should include(key)
    actual_subvalue1 = coerce_value(@report.conclusion[key.to_s][subkey1.to_sym].to_s)
    compare_values(actual_subvalue1, subvalue1)
    actual_subvalue2 = coerce_value(@report.conclusion[key.to_s][subkey2.to_sym].to_s)
    compare_values(actual_subvalue2, subvalue2)
  else
    @report.conclusion.keys.map(&:to_s).should be_blank
  end
end
