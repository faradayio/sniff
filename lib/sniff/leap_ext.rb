module Leap
  module Trace
    def trace
      @deliberations.inject({}) do |delibs, (goal, deliberation)|
        delibs[goal] = deliberation.reports.inject([]) do |reports, report|
          item = {
            :committee => report.committee.name,
            :quorum => report.quorum.name,
            :result => deliberation[report.committee.name].to_s,
          }

          item[:params] = report.quorum.characteristics.inject({}) do |hsh, name|
            hsh[name] = deliberation[name].to_s
            hsh
          end

          reports << item
        end
        delibs
      end
    end

    def trace_report
      trace.each do |goal, steps|
        puts goal
        if steps
          steps.each do |step|
            puts "  #{step[:committee]} #{step[:quorum]}"
            unless step[:params].empty?
              puts "    Params: "
              step[:params].inspect.split("\n").each { |p| puts "      #{p}" }
            end
            puts "    Result: #{step[:result].inspect}\n"
          end
        else
          puts "  Not computed"
        end
      end
    end
  end
end
