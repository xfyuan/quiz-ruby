class Talk
  LIGHTNING_LENGTH = 5
  LUNCH_LENGTH     = 60
  TIME_UNIT        = 'min'.freeze
  NORMAL_TAG       = 'normal'.freeze
  LIGHTNING_TAG    = 'lightning'.freeze
  DEFAULT_TAG      = 'default'.freeze
  PUBLIC_EVENT     = ['lunch', 'networking event'].freeze

  attr_accessor(:title, :length, :tag, :time_unit, :marked)

  def initialize(input)
    @length    = LUNCH_LENGTH
    @tag       = DEFAULT_TAG
    @time_unit = TIME_UNIT
    @marked    = false
    read_source(input)
  end

  def read_source(input)
    @title = input.split.map(&:capitalize).join(' ') if PUBLIC_EVENT.include?(input.downcase)

    /#{talk_regex}/i.match(input) do |m|
      @title  = m[1]
      @length = normal_talk?(m[2]) ? m[3].to_i : LIGHTNING_LENGTH
      @tag    = normal_talk?(m[2]) ? NORMAL_TAG : LIGHTNING_TAG
    end
  end

  def to_s
    if @tag == NORMAL_TAG
      "#{@title} #{@length}#{@time_unit}"
    elsif @tag == LIGHTNING_TAG
      "#{@title} #{@tag}"
    else
      @title
    end
  end


  private

    def talk_regex
      "(.*)\\s((\\d+)\\s*#{TIME_UNIT}|#{LIGHTNING_TAG})$"
    end

    def normal_talk?(parsed)
      /\d+/i.match(parsed)
    end
end
