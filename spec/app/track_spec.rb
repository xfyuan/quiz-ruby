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
end
