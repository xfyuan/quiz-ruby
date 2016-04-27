RSpec.describe Conference do
  let(:conference) { build(:conference) }

  it 'has properties' do
    expect(conference).to respond_to :days
    expect(conference).to respond_to :talks
    expect(conference).to respond_to :tracks
  end

  it 'initialize data source' do
    expect(conference.days).to eq 2
    expect(conference.talks).to be_a Array
    expect(conference.talks.length).to eq 19
    expect(conference.tracks).to be_a Array
    expect(conference.tracks.length).to eq 2
  end

  it 'schedule tracks with full talks' do
    conference.schedule_tracks_with_talks
    expect(conference.tracks.first.talks.length).to eq 8
    expect(conference.tracks.last.talks.length).to eq 11
  end
end
