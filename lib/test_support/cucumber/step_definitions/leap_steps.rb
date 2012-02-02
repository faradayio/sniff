Given %r{a decision is to be made on "(.*)"} do |decision|
  @decision = @activity.decisions[decision.to_sym]
end

Then /trace the calculation/ do
  @activity_instance.class.send :include, Leap::Trace
  @activity_instance.trace_report
end
