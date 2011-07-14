Then /trace the calculation/ do
  @activity.class.send :include, Leap::Trace
  @activity.trace_report
end
