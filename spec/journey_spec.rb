require 'journey'

describe Journey do
  let (:station) {double :station_struct}
  subject(:journey) {described_class.new}
  let (:card) {double :oystercard}
  let (:station2) {double :station_struct}
  before do
    allow(station).to receive(:zone) {1}
    allow(station2).to receive(:zone) {5}
  end

  context 'journey record' do
    before {subject.journey_start station}

    it 'should have a journey_start method and a reader method' do
      expect(subject.starting_station).to eq station
    end

    it 'should have a journey_end method and a reader method' do
      subject.journey_end station2
      expect(subject.exit_station).to eq station2
    end

    describe '#calculate_fare' do
      it 'returns a penalty fare when journey is incomplete' do
        expect(subject.calculate_fare).to eq Journey::PENALTY_FARE
      end

      it 'calculates the fare correctly when the journey is completed' do
        subject.journey_end(station2)
        expect(subject.calculate_fare).to eq 5
      end
    end

  end
end
