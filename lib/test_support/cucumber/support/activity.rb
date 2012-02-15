module Sniff
  module Activity
    attr_accessor :activity, :activity_instance, :expectations, :characteristics,
      :current_date, :impact, :decision, :timeframe

    def init_activity(activity = Supplier, instance = nil)
      self.activity = activity
      instance ||= activity.new
      self.activity_instance = instance
      self.expectations = []
      self.characteristics = activity_instance.characteristics.characteristics.inject({}) do |hsh, (name, curation)|
        hsh[name] = curation.value
        hsh
      end
    end

    def blessed_characteristics
      characteristics.inject({}) do |memo, (k,v)|
        memo[k] = Charisma::Curator::Curation.new v, activity.characterization[k]
        memo
      end
    end

    def decision
      @decision ||= activity.decisions.values.first
    end

    def committee(name = nil)
      if name
        @committee = decision.committees.find { |c| c.name.to_s == name }
      else
        @committee
      end
    end

    def args
      arguments = [blessed_characteristics]
      if timeframe
        arguments << [timeframe]
      else
        arguments << []
      end
      arguments
    end

    def report(committee_name = nil)
      if committee_name
        @report = committee(committee_name).report *args
      else
        @report
      end
    end
  end
end
