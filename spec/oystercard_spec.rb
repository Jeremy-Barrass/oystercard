require "oystercard"

describe Oystercard do
  subject(:oystercard) {described_class.new}
  let (:station) {double :station}
  let (:station2) {double :station}
  before do
    allow(station).to receive(:zone) {1}
    allow(station2).to receive(:zone) {5}
  end
  cash = 80
  fare = 3

  context 'Money' do
    describe 'balance' do
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
  end

    context 'Journey' do
      let (:new_card) {Oystercard.new}

      before do
        subject.top_up(cash)
        subject.touch_in station
      end

      it 'raises an error when the MIN_BALANCE is not available' do
        expect{new_card.touch_in(station)}.to raise_error
      end

      it 'deducts money after journey' do
        expect{subject.touch_out(station)}.to change{subject.balance}.by -1
      end

      it 'stores logs of journey in an array of journey hashes' do
        subject.touch_out station2
        expect(subject.hist).to eq [{station => station2}]
      end

  end
end
