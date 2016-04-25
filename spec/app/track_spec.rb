RSpec.describe Track do
  let(:track) { build(:track) }

  it 'has properties' do
    expect(track.talks).to be_a Array
    expect(track.planned_talks).to be_a Hash
    expect(track.start_time).to be_a Time
    expect(track.end_time).to be_a Time
    expect(track.lunch_time).to be_a Time
    expect(track.total_length).to be_a Numeric
  end

  it 'initialize total length of current track' do
    expect(track.total_length).to eq (track.end_time - track.start_time - 60 * 60) / 60
  end

  it 'has planned talks of current track' do
    track.plan_talks
    expect(track.planned_talks.keys).to eq [
      :'09:00AM',
      :'10:00AM',
      :'10:45AM',
      :'11:15AM',
      :'12:00PM',
      :'01:00PM',
      :'05:00PM'
    ]
  end

  it 'output string of current track with full talks' do
    track.plan_talks
    expect(track.to_s).to be
      <<~EOF
        09:00AM Writing Fast Tests Against Enterprise Rails 60min
        10:00AM Overdoing it in Python 45min
        10:45AM Lua for the Masses 30min
        11:15AM Ruby Errors from Mismatched Gem Versions 45min
        12:00PM Lunch
        01:00PM Ruby on Rails: Why We Should Move On 60min
        05:00PM Networking Event
      EOF
  end
end
