require "oystercard"

describe Oystercard do
  subject(:oystercard) {described_class.new}
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

      it 'deducts the fare for a journey from the card' do
        oystercard.deduct_fare(fare)
        expect{subject.deduct_fare(fare)}.to change{oystercard.balance}.by -fare
      end
    end

    context 'journey' do
      let (:new_card) {Oystercard.new}

      before {subject.touch_in}

      it 'saves when a journey has been started' do
        expect(subject).to be_in_journey
      end

      it 'sets in_journey to false upon touch_out' do
        subject.touch_out
        expect(subject).not_to be_in_journey
      end

      it 'sets false as the default state for class Oystercard' do
        expect(new_card).not_to be_in_journey
      end
    end

  end
end
