RSpec.describe Conference do
  let(:conference) { build(:conference) }

  context 'initialize' do
    it 'has properties' do
      expect(conference).to respond_to :days
      expect(conference).to respond_to :talks
      expect(conference).to respond_to :tracks
      expect(conference).to respond_to :schedule_result
      expect(conference).to respond_to :invalid_talks
    end

    it 'read data source' do
      expect(conference.days).to eq 2
      expect(conference.talks).to be_a Array
      expect(conference.talks.length).to eq 19
      expect(conference.tracks).to be_a Array
      expect(conference.tracks.length).to eq 2
    end
  end

  context 'tracks with valid talks' do
    before do
      conference.schedule_tracks_with_talks
    end

    it 'schedule tracks with full talks' do
      expect(conference.tracks.first.talks.length).to eq 8
      expect(conference.tracks.last.talks.length).to eq 11
    end

    it 'output scheduled tracks' do
      conference.render_scheduled_tracks
      expect(conference.schedule_result.length).to eq 2
      expect(conference.schedule_result).to eq (
        [
          ["09:00AM Communicating Over Distance 60min",
           "10:00AM Ruby on Rails: Why We Should Move On 60min",
           "11:00AM Rails Magic 60min",
           "12:00PM Lunch",
           "01:00PM Ruby on Rails Legacy App Maintenance 60min",
           "02:00PM Writing Fast Tests Against Enterprise Rails 60min",
           "03:00PM Overdoing it in Python 45min",
           "03:45PM Common Ruby Errors 45min",
           "04:30PM User Interface CSS in Rails Apps 30min",
           "05:00PM Networking Event"
          ],
          ["09:00AM Ruby Errors from Mismatched Gem Versions 45min",
          "09:45AM Clojure Ate Scala (on my project) 45min",
          "10:30AM Pair Programming vs Noise 45min",
          "11:15AM Accounting-Driven Development 45min",
          "12:00PM Lunch",
          "01:00PM Ruby vs. Clojure for Back-End Development 30min",
          "01:30PM Programming in the Boondocks of Seattle 30min",
          "02:00PM Sit Down and Write 30min",
          "02:30PM Woah 30min",
          "03:00PM A World Without HackerNews 30min",
          "03:30PM Lua for the Masses 30min",
          "04:00PM Rails for Python Developers lightning",
          "05:00PM Networking Event"
          ]
        ]
      )
    end
  end

  context 'tracks with invalid talks' do
    let(:invalid_talk) { build :talk, input: 'QWESdfghji fgh=> !@#$%^&*()' }

    before do
      conference.talks << invalid_talk
      conference.schedule_tracks_with_talks
    end

    it 'schedule tracks with invalid talks' do
      expect(conference.tracks.first.talks.length).to eq 8
      expect(conference.tracks.last.talks.length).to eq 11
    end

    it 'output scheduled tracks' do
      conference.render_scheduled_tracks
      expect(conference.invalid_talks).to eq ["!!Invalid talk: QWESdfghji fgh=> !@\#$%^&*()"]
    end

  end
end
