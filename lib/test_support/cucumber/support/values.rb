require 'date'

def coerce_value(value)
  # what is this, PHP?
  if value.nil?
    nil
  elsif value == 'true'
    true
  elsif value == 'false'
    false
  elsif value =~ /\d+\.\d+/
    value.to_f
  elsif value =~ /^\d+$/
    value.to_i
  else
    value
  end
end

def compare_values(a, b)
  if b.nil? or b.empty?
    a.should be_nil
  elsif a.is_a? Date or a.is_a? Time
    b = Date.parse b
    a.should == b
  elsif b =~ /\d+\.\d+/
    b = b.to_f
    a.should be_close(b, 0.00001)
  elsif b =~ /^\d+$/
    b = b.to_i
    a.should == b
  else
    a.should == b
  end
end

def equality?(a, b)
  if b.nil? or b.empty?
    a.nil?
  elsif a.is_a? Date or a.is_a? Time
    b = Date.parse b
    a == b
  elsif b =~ /\d+\.\d+/
    (a.to_f - b.to_f).abs <= 0.00001
  elsif b =~ /^\d+$/
    a.to_i == b.to_i
  else
    a == b
  end
end
