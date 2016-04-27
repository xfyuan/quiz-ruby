class Track
  START_TIME   = Time.parse('09:00').freeze
  LUNCH_TIME   = Time.parse('12:00').freeze
  END_TIME     = Time.parse('17:00').freeze
  LUNCH_LENGTH = 1 * 60 * 60

  attr_accessor(:start_time, :end_time, :lunch_time, :total_length, :talks, :planned_talks)

  def initialize
    @start_time   = START_TIME
    @lunch_time   = LUNCH_TIME
    @end_time     = END_TIME
    @total_length = (END_TIME - START_TIME - LUNCH_LENGTH) / 60
  end

  def plan_talks
    dts = @start_time
    @planned_talks = planned_talks_with_lunch(dts)
    fill_network_event
  end

  def to_s
    @planned_talks.map { |time_tag, talk| "#{time_tag.to_s} #{talk.to_s}" }
  end


  private

    def planned_talks_with_lunch(dts)
      @talks.each_with_object({}) do |talk, memo|
        memo[time_tag(dts)] = talk
        dts += talk.length * 60

        if (@lunch_time - dts).to_i.abs < (5 * 60)
          memo[time_tag(@lunch_time)] = Talk.new('Lunch')
          dts += LUNCH_LENGTH
        end
      end
    end

    def fill_network_event
      @planned_talks[time_tag(END_TIME)] = Talk.new('Networking Event')
    end

    def time_tag(dts)
      dts.to_datetime.strftime('%I:%M%p').to_sym
    end

end
