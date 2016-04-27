RSpec.describe Talk do
  let(:talk) { build(:talk) }

  it 'has properties' do
    expect(talk).to respond_to :title
    expect(talk).to respond_to :tag
    expect(talk).to respond_to :length
    expect(talk).to respond_to :time_unit
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

  it 'output string of normal talk' do
    expect(talk.render).to match /Test talk(\d+) 45min/
  end

  it 'output string of lightning talk' do
    talk.read_source('Common Ruby Errors lightning')
    expect(talk.render).to eq 'Common Ruby Errors lightning'
  end
end
