class Track
  START_TIME   = Time.parse('09:00').freeze
  LUNCH_TIME   = Time.parse('12:00').freeze
  END_TIME     = Time.parse('17:00').freeze
  LUNCH_LENGTH = 60

  attr_accessor(:start_time, :end_time, :lunch_time, :lunch_length, :total_length, :talks, :planned_talks)

  def initialize(start_time = START_TIME, end_time = END_TIME, lunch_time = LUNCH_TIME, lunch_length = LUNCH_LENGTH)
    @start_time, @end_time, @lunch_time, @lunch_length = start_time, end_time, lunch_time, lunch_length
    @total_length = (@end_time - @start_time) / 60 - @lunch_length
  end

  def plan_talks
    @planned_talks = planned_talks_with_lunch
    fill_network_event
  end

  def render
    @planned_talks.map { |time_tag, talk| "#{time_tag.to_s} #{talk.render}" }
  end

  private

    def planned_talks_with_lunch
      dts = @start_time
      @talks.each_with_object({}) do |talk, memo|
        memo[time_tag(dts)] = talk
        dts += talk.length * 60

        if (@lunch_time - dts).to_i.abs < (5 * 60)
          memo[time_tag(@lunch_time)] = Talk.new('Lunch')
          dts += @lunch_length * 60
        end
      end
    end

    def fill_network_event
      @planned_talks[time_tag(@end_time)] = Talk.new('Networking Event')
    end

    def time_tag(dts)
      dts.to_datetime.strftime('%I:%M%p').to_sym
    end

end
