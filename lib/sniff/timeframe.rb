# Encapsulates a timeframe between two dates. The dates provided to the class are always until the last date. That means
# that the last date is excluded.
#
#   # from 2007-10-01 00:00:00.000 to 2007-10-31 23:59:59.999
#   Timeframe.new(Date(2007,10,1), Date(2007,11,1))
#   # and holds 31 days
#   Timeframe.new(Date(2007,10,1), Date(2007,11,1)).days #=> 31

module Sniff
  class Timeframe
    attr_accessor :from, :to

    # Creates a new instance of Timeframe. You can either pass a start and end Date or a Hash with named arguments,
    # with the following options:
    #
    #   <tt>:month</tt>: Start date becomes the first day of this month, and the end date becomes the first day of
    #   the next month. If no <tt>:year</tt> is specified, the current year is used.
    #   <tt>:year</tt>: Start date becomes the first day of this year, and the end date becomes the first day of the
    #   next year.
    #
    # Examples:
    #
    #   Timeframe.new Date.new(2007, 2, 1), Date.new(2007, 4, 1) # February and March
    #   Timeframe.new :year => 2004 # The year 2004
    #   Timeframe.new :month => 4 # April
    #   Timeframe.new :year => 2004, :month => 2 # Feburary 2004
    def initialize(*args)
      options = args.extract_options!

      if month = options[:month]
        month = Date.parse(month).month if month.is_a? String
        year = options[:year] || Time.zone.today.year
        from = Date.new(year, month, 1)
        to   = from.next_month
      elsif year = options[:year]
        from = Date.new(year, 1, 1)
        to   = Date.new(year+1, 1, 1)
      end

      from ||= args.shift.andand.to_date
      to ||= args.shift.andand.to_date

      raise ArgumentError, "Please supply a start and end date, `#{args.map(&:inspect).to_sentence}' is not enough" if from.nil? or to.nil?
      raise ArgumentError, "Start date #{from} should be earlier than end date #{to}" if from > to
      raise ArgumentError, 'Timeframes that cross year boundaries are dangerous' unless options[:skip_year_boundary_crossing_check] or from.year == to.yesterday.year or from == to

      @from, @to = from, to
    end
    
    def inspect
      "<Timeframe(#{object_id}) #{days} days starting #{from} ending #{to}>"
    end

    # The number of days in the timeframe
    #
    #   Timeframe.new(Date.new(2007, 11, 1), Date.new(2007, 12, 1)).days #=> 30
    #   Timeframe.new(:month => 1).days #=> 31
    #   Timeframe.new(:year => 2004).days #=> 366
    def days
      (to - from).to_i
    end
    
    # Returns a string representation of the timeframe
    def to_s
      if [from.day, from.month, to.day, to.month].uniq == [1]
        from.year.to_s
      elsif from.day == 1 and to.day == 1 and to.month - from.month == 1
        "#{Date::MONTHNAMES[from.month]} #{from.year}"
      else
        "the period from #{from.strftime('%d %B')} to #{to.yesterday.strftime('%d %B %Y')}"
      end
    end

    # Returns true when the date is included in this Timeframe
    def include?(obj)
      # puts "checking to see if #{date} is between #{from} and #{to}" if Emitter::DEBUG
      case obj
      when Date
        (from...to).include?(obj)
      when Time
        # (from...to).include?(obj.to_date)
        raise "this wasn't previously supported, but it could be"
      when Timeframe
        from <= obj.from and to >= obj.to
      end
    end
    
    def proper_include?(other_timeframe)
      raise ArgumentError, 'Proper inclusion only makes sense when testing other Timeframes' unless other_timeframe.is_a? Timeframe
      (from < other_timeframe.from) and (to > other_timeframe.to)
    end
    
    # Returns true when this timeframe is equal to the other timeframe
    def ==(other)
      # puts "checking to see if #{self} is equal to #{other}" if Emitter::DEBUG
      return false unless other.is_a?(Timeframe)
      from == other.from and to == other.to
    end
    alias :eql? :==
      
    # Calculates a hash value for the Timeframe, used for equality checking and Hash lookups.
    # This needs to be an integer or else it won't use #eql?
    def hash
      from.hash + to.hash
    end
    alias :to_param :hash
    
    # Returns an array of month-long subtimeframes
    # TODO: rename to month_subtimeframes
    def months
      raise ArgumentError, "Please only provide whole-month timeframes to Timeframe#months" unless from.day == 1 and to.day == 1
      raise ArgumentError, 'Timeframes that cross year boundaries are dangerous during Timeframe#months' unless from.year == to.yesterday.year
      year = from.year # therefore this only works in the from year
      (from.month..to.yesterday.month).map { |m| Timeframe.new :month => m, :year => year }
    end
    
    # Returns the relevant year as a Timeframe
    def year
      raise ArgumentError, 'Timeframes that cross year boundaries are dangerous during Timeframe#year' unless from.year == to.yesterday.year
      Timeframe.new :year => from.year
    end
    
    # multiyear safe
    def month_subtimeframes
      (from.year..to.yesterday.year).map do |year|
        (1..12).map do |month|
          Timeframe.new(:year => year, :month => month) & self
        end
      end.flatten.compact
    end
    
    # multiyear safe
    def full_month_subtimeframes
      month_subtimeframes.map { |st| Timeframe.new(:year => st.from.year, :month => st.from.month) }
    end
    
    # multiyear safe
    def year_subtimeframes
      (from.year..to.yesterday.year).map do |year|
        Timeframe.new(:year => year) & self
      end
    end
    
    # multiyear safe
    def full_year_subtimeframes
      (from.year..to.yesterday.year).map do |year|
        Timeframe.new :year => year
      end
    end
    
    # multiyear safe  
    def ending_no_later_than(date)
      if to < date
        self
      elsif from >= date
        nil
      else
        Timeframe.multiyear from, date
      end
    end
      
    # Returns a timeframe representing the intersection of the timeframes
    def &(other_timeframe)
      this_timeframe = self
      if other_timeframe == this_timeframe
        this_timeframe
      elsif this_timeframe.from > other_timeframe.from and this_timeframe.to < other_timeframe.to
        this_timeframe
      elsif other_timeframe.from > this_timeframe.from and other_timeframe.to < this_timeframe.to
        other_timeframe
      elsif this_timeframe.from >= other_timeframe.to or this_timeframe.to <= other_timeframe.from
        nil
      else
        Timeframe.new [this_timeframe.from, other_timeframe.from].max, [this_timeframe.to, other_timeframe.to].min, :skip_year_boundary_crossing_check => true
      end
    end
    
    # Returns a fraction of another Timeframe
    def /(other_timeframe)
      raise ArgumentError, 'You can only divide a Timeframe by another Timeframe' unless other_timeframe.is_a? Timeframe
      self.days.to_f / other_timeframe.days.to_f
    end
    
    def crop(container)
      raise ArgumentError, 'You can only crop a timeframe by another timeframe' unless container.is_a? Timeframe
      self.class.new [from, container.from].max, [to, container.to].min
    end
    
    def gaps_left_by(*timeframes)
      # remove extraneous timeframes
      timeframes.reject! { |t| t.to <= from }
      timeframes.reject! { |t| t.from >= to }
      
      # crop timeframes
      timeframes.map! { |t| t.crop self }
      
      # remove proper subtimeframes
      timeframes.reject! { |t| timeframes.detect { |u| u.proper_include? t } }
      
      # escape
      return [self] if  timeframes.empty?

      timeframes.sort! { |x, y| x.from <=> y.from }
      
      timeframes.collect(&:to).unshift(from).ykk(timeframes.collect(&:from).push(to)) do |gap|
        Timeframe.new(*gap) if gap[1] > gap[0]
      end.compact
    end
    
    def covered_by?(*timeframes)
      gaps_left_by(*timeframes).empty?
    end
    
    def last_year
      self.class.new((from - 1.year), (to - 1.year))
    end
    
    class << self
      def this_year
        new :year => Time.now.year
      end
      
      def constrained_new(from, to, constraint)
        raise ArgumentError, 'Need Date, Date, Timeframe as args' unless from.is_a? Date and to.is_a? Date and constraint.is_a? Timeframe
        raise ArgumentError, "Start date #{from} should be earlier than end date #{to}" if from > to
        if to <= constraint.from or from >= constraint.to
          new constraint.from, constraint.from
        elsif from.year == to.yesterday.year
          new(from, to) & constraint
        elsif from.year < constraint.from.year and constraint.from.year < to.yesterday.year
          constraint
        else
          new [constraint.from, from].max, [constraint.to, to].min
        end
      end
      
      def multiyear(from, to)
        from = Date.parse(from) if from.is_a?(String)
        to = Date.parse(to) if to.is_a?(String)
        new from, to, :skip_year_boundary_crossing_check => true
      end
      
      # create a multiyear timeframe +/- number of years around today
      def mid(number)
        from = Time.zone.today - number.years
        to = Time.zone.today + number.years
        multiyear from, to
      end
    end
  end
end
