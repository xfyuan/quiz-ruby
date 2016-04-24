class Conference
  attr_accessor(:days, :talks, :tracks, :scheduled_tracks)

  def initialize(data)
    read_source(data)
    refresh_days()
    refresh_tracks()
  end

  def schedule_tracks_with_talks
    sort_talks()
    @tracks.each do |track|
      track.talks = talks_in_current_track(track)
      track.plan_talks()
    end
  end

  private

    def read_source(data)
      @talks = data.lines.map(&:chomp).map(&:strip).reject(&:empty?).map { |line| Talk.new(line) }
    end

    def refresh_days
      minutes = @talks.reduce(0) { |memo, talk| memo += talk.length }
      @days = (minutes.to_f/Track.new.total_length).ceil
    end

    def refresh_tracks
      @tracks = @days.times.map { |n| Track.new }
    end

    def sort_talks
      @talks.sort_by! { |talk| talk.length }.reverse!
    end

    def talks_in_current_track(track)
      track_total_length = track.total_length
      @talks.reduce([]) do |memo, talk|
        if !talk.marked && track_total_length >= talk.length
          memo << talk
          talk.marked = true
          track_total_length -= talk.length
        end
        memo
      end
    end

end
