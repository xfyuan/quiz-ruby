RSpec.describe Talk do
  let(:talk) { build(:talk) }

  it 'has properties' do
    expect(talk.title).to be_a String
    expect(talk.tag).to be_a String
    expect(talk.length).to be_a Numeric
    expect(talk.time_unit).to be_a String
    expect(talk.marked).to be false
  end

  it 'initial property value through reading a normal talk' do
    expect(talk.title).to include 'Test talk'
    expect(talk.tag).to eq 'normal'
    expect(talk.time_unit).to eq 'min'
    expect(talk.length).to eq 45
  end

  it 'initial property value through reading a lightning talk' do
    talk.read_source('Common Ruby Errors lightning')
    expect(talk.title).to eq 'Common Ruby Errors'
    expect(talk.tag).to eq 'lightning'
    expect(talk.time_unit).to eq 'min'
    expect(talk.length).to eq 5
  end
end
