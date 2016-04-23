class Talk
  LIGHTNING_LENGTH = 5
  LUNCH_LENGTH     = 60
  TIME_UNIT        = 'min'
  NORMAL_TAG       = 'normal'
  LIGHTNING_TAG    = 'lightning'
  DEFAULT_TAG      = 'default'
  IS_PUBLIC_EVENT  = true

  attr_accessor(:title, :length, :tag, :time_unit, :marked)

  def initialize
    self.time_unit = TIME_UNIT
    self.marked    = false
  end

  def read_source(input)
    /#{talk_regex}/i.match(input) do |m|
      self.title  = m[1]
      self.length = is_normal_talk(m[2]) ? m[3].to_i : LIGHTNING_LENGTH
      self.tag    = is_normal_talk(m[2]) ? NORMAL_TAG : LIGHTNING_TAG
    end
  end


  private

    def talk_regex
      "(.*)\\s((\\d+)\\s*#{TIME_UNIT}|#{LIGHTNING_TAG})$"
    end

    def is_normal_talk(parsed)
      /\d+/i.match(parsed)
    end
end
