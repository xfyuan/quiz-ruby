RSpec.describe Talk do
  let(:talk) { build(:talk) }

  it 'has properties' do
    expect(talk).to respond_to :title
    expect(talk).to respond_to :tag
    expect(talk).to respond_to :length
    expect(talk).to respond_to :time_unit
    expect(talk).to respond_to :errors
    expect(talk.marked).to be false
    expect(talk.errors).to be_a Array
  end

  context 'initial property value' do
    it 'reading a normal talk' do
      expect(talk.errors.length).to eq 0
      expect(talk.title).to include 'Test talk'
      expect(talk.tag).to eq 'normal'
      expect(talk.time_unit).to eq 'min'
      expect(talk.length).to eq 45
    end

    it 'reading a lightning talk' do
      talk.read_source('Common Ruby Errors lightning')
      expect(talk.errors.length).to eq 0
      expect(talk.title).to eq 'Common Ruby Errors'
      expect(talk.tag).to eq 'lightning'
      expect(talk.time_unit).to eq 'min'
      expect(talk.length).to eq 5
    end
  end

  context 'validation' do
    let(:talk) { build :talk, input: 'QWESdfghji fgh=> !@#$%^&*()' }

    it 'reading a invalid talk' do
      expect(talk.errors.length).to be > 0
    end
  end

  context 'render output' do
    it 'output string of normal talk' do
      expect(talk.render).to match(/Test talk(\d+) 45min/)
    end

    it 'output string of lightning talk' do
      talk.read_source('Common Ruby Errors lightning')
      expect(talk.render).to eq 'Common Ruby Errors lightning'
    end
  end
end
