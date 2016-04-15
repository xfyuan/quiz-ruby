RSpec.describe Talk do
  let(:talk) { build(:talk) }

  it 'should has properties' do
    expect(talk.title).to be_a String
    expect(talk.tag).to be_a String
    expect(talk.length).to be_a Numeric
    expect(talk.time_unit).to be_a String
    expect(talk.marked).to be false
  end
end
