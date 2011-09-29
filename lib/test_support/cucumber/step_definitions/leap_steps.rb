Then /trace the calculation/ do
  @activity_instance.class.send :include, Leap::Trace
  @activity_instance.trace_report
end
