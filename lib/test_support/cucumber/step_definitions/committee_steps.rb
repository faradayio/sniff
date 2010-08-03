Given /^a purchase emitter$/ do
  @activity = PurchaseRecord
end

Given /^(a )?characteristic "(.*)" of "(.*)"$/ do |_, name, value|
  @characteristics ||= {}

  if name =~ /\./
    model_name, attribute = name.split /\./
    model = model_name.singularize.camelize.constantize
    value = model.send "find_by_#{attribute}", value
    @characteristics[model_name.to_sym] = value
  else
    value = coerce_value(value)
    @characteristics[name.to_sym] = value
  end
end

When /^the "(.*)" committee is calculated$/ do |committee_name|
  @decision ||= @activity.decisions[:emission]
  @committee = @decision.committees.find { |c| c.name.to_s == committee_name }
  @report = @committee.report(@characteristics, [])
  @characteristics[committee_name.to_sym] = @report.conclusion
end

Then /^the committee should have used quorum "(.*)"$/ do |quorum|
  @report.quorum.name.should == quorum
end

Then /^the conclusion of the committee should be "(.+)"$/ do |conclusion|
  compare_values(@report.conclusion, conclusion)
end

Then /^the conclusion of the committee should include a key of (.*) and value (.*)$/ do |key, value|
  if key.present?
    @report.conclusion.keys.map(&:to_s).should include(key)
  else
    @report.conclusion.keys.map(&:to_s).should be_empty
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
  report_value.should == coerce_value(value)
end

Then /^the conclusion of the committee should have a record identified with "(.*)" of "(.*)" and having "(.*)" of "(.*)"$/ do |id_field, id, field, value|
  id_field = id_field.to_sym
  records = @report.conclusion
  record = records.send("find_by_#{id_field}", id)
  coerce_value(record.send(field)).should == coerce_value(value)
end

Then /^the conclusion of the committee should include a key of "(.*)" and subvalue "(.*)" of "(.*)" and subvalue "(.*)" of "(.*)"$/ do |key, subkey1, subvalue1, subkey2, subvalue2|
  if key.present?
    @report.conclusion.keys.map(&:to_s).should include(key)
    actual_subvalue1 = coerce_value(@report.conclusion[key.to_s][subkey1.to_sym].to_s)
    compare_values(actual_subvalue1, subvalue1)
    actual_subvalue2 = coerce_value(@report.conclusion[key.to_s][subkey2.to_sym].to_s)
    compare_values(actual_subvalue2, subvalue2)
  else
    @report.conclusion.keys.map(&:to_s).should be_empty
  end
end
