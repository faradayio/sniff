def coerce_value(value)
  if value =~ /\d+\.\d+/
    value.to_f
  elsif value =~ /^\d+$/
    value.to_i
  else
    value
  end
end

def compare_values(a, b)
  if b =~ /\d+\.\d+/
    b = b.to_f
    a.should be_close(b, 0.00001)
  elsif b =~ /^\d+$/
    b = b.to_i
    a.should == b
  else
    a.should == b
  end
end
