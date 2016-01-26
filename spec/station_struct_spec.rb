require 'station_struct'

describe Station do
  subject(:station) {described_class.new("Aldgate East",1)}
  it 'has a human readable name' do
    expect(subject.name).to eql "Aldgate East"
  end

  it 'has a zone' do
    expect(subject.zone).to eql 1
  end
end
