class Conference
  attr_accessor(:days, :talks, :tracks, :schedule_result, :invalid_talks)

  def initialize(data)
    read_source(data)
    refresh_days
    refresh_tracks
  end

  def schedule_tracks_with_talks
    filter_invalid_talks
    sort_talks
    @tracks.each do |track|
      track.talks = talks_in_current_track(track)
      track.plan_talks
    end
  end

  def render_scheduled_tracks
    @schedule_result = @tracks.each_with_object([]) { |track, memo| memo << track.render }
    @invalid_talks.map! { |talk| talk.errors.to_s }
  end

  private

    def read_source(data)
      @talks = data.lines.map(&:chomp).map(&:strip).reject(&:empty?).map { |line| Talk.new(line) }
    end

    def refresh_days
      minutes = @talks.map(&:length).reduce(:+)
      @days = (minutes.to_f / Track.new.total_length).ceil
    end

    def refresh_tracks
      @tracks = Array.new(@days) { Track.new }
    end

    def sort_talks
      @talks.sort_by!(&:length).reverse!
    end

    def filter_invalid_talks
      @invalid_talks = @talks.reject { |t| t.errors.empty? }
      @talks.keep_if { |t| t.errors.empty? }
    end

    def talks_in_current_track(track)
      track_total_length = track.total_length
      @talks.each_with_object([]) do |talk, memo|
        if !talk.marked && track_total_length >= talk.length
          memo << talk
          talk.marked = true
          track_total_length -= talk.length
        end
      end
    end

end
