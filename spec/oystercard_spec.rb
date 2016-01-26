require "oystercard"

describe Oystercard do
  subject(:oystercard) {described_class.new}
  let (:station) {double :station}
  let (:station2) {double :station}
  cash = 5
  fare = 3

  context 'Money' do
    describe '#balance' do
      it 'Has a default balance of 0' do
        expect(oystercard.balance).to eq Oystercard::DEFAULT_BALANCE
      end

      it 'Can have money added to it' do
        oystercard.top_up(cash)
        expect(oystercard.balance).to eq cash
      end

      it 'throws an error when MAX_LIMIT is passed on card' do
        expect{oystercard.top_up(Oystercard::MAX_LIMIT + 1)}.to raise_error
      end
    end

    context 'journey' do
      let (:new_card) {Oystercard.new}

      before do
        subject.top_up(cash)
        subject.touch_in station
      end

      it 'saves when a journey has been started' do
        expect(subject).to be_in_journey
      end

      it 'sets in_journey to false upon touch_out' do
        subject.touch_out(station)
        expect(subject).not_to be_in_journey
      end

      it 'sets false as the default state for class Oystercard' do
        expect(new_card).not_to be_in_journey
      end

      it 'raises an error when the MIN_BALANCE is not available' do
        expect{new_card.touch_in(station)}.to raise_error
      end

      it 'deducts money after journey' do
        expect{subject.touch_out(station)}.to change{subject.balance}.by -Oystercard::MIN_FARE
      end
    end

    context 'payment calculation' do
      it {is_expected.to respond_to(:starting_station)}

      before do
        subject.top_up(cash)
        subject.touch_in station
      end

      it 'saves the starting station' do
        expect(subject.starting_station).to eq station
      end

      it 'sets the starting station to nil on touch out' do
        subject.touch_out(station)
        expect(subject.starting_station).to be(nil)
      end

      it 'exit_station is nil by default' do
        expect(subject.exit_station).to eq nil
      end

      it 'sets exit_station to the correct station after touch_out' do
        subject.touch_out station2
        expect(subject.exit_station).to eq station2
      end

      it 'resets exit_station to nil on touch_in' do
        subject.touch_out station2
        subject.touch_in station
        expect(subject.exit_station).to eq nil
      end

      it 'stores logs of journey in an array of journey hashes' do
        subject.touch_out station2
        expect(subject.hist).to eq [{station => station2}]
      end
    end

  end
end
