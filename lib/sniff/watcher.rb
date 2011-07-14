if __FILE__ == $0
  puts "Run with: watchr #{__FILE__}. \n\nRequired gems: watchr rev"
  exit 1
end

# --------------------------------------------------
# Convenience Methods
# --------------------------------------------------
def run(cmd)
  system 'clear'
  puts(cmd)
  system cmd
end

def run_all_tests
  run_all_specs if File.exist? 'spec'
  run_all_cukes if File.exist? 'features'
end

def run_all_specs
  unless Dir['spec/**/*_spec.rb'].empty?
    run "bundle exec rspec spec"
  end
end

def run_single_spec *spec
  unless Dir['spec/**/*_spec.rb'].empty?
    spec = spec.join(' ')
    run "bundle exec rspec #{spec}"
  end
end

def run_all_cukes
  unless Dir['features/*.feature'].empty?
    run "bundle exec cucumber features"
  end
end

def run_single_cuke scenario_path
  run "bundle exec cucumber #{scenario_path}"
end

# --------------------------------------------------
# Watchr Rules
# --------------------------------------------------
watch( '^spec/spec_helper\.rb'                    ) {     run_all_specs }
watch( '^spec/.*_spec\.rb'                        ) { |m| run_single_spec(m[0]) }
watch( '^app/(.*)\.rb'                            ) { |m| run_single_spec("spec/%s_spec.rb" % m[1]) }
watch( '^lib/(.*)\.rb'                            ) do |m|
  run_single_spec("spec/lib/%s_spec.rb" % m[1] )
  run_all_cukes
end
watch( '^features/.*\.feature'                    ) { |m| run_single_cuke(m[0]) }


# --------------------------------------------------
# Signal Handling
# --------------------------------------------------
# Ctrl-\
Signal.trap('QUIT') do
  puts " --- Running all tests ---\n\n"
  run_all_tests
end
 
# Ctrl-C
Signal.trap('INT') { abort("\n") }
