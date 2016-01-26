require "oystercard"

describe Oystercard do
  subject(:oystercard) {described_class.new}

  context 'Money' do
    it {is_expected.to respond_to(:balance)}
    describe '#balance' do
      it 'Has a default balance of 0' do
        expect(oystercard.balance).to eq Oystercard::DEFAULT_BALANCE
      end

      it 'Can have money added to it' do
        cash = 5
        oystercard.add(cash)
        expect(oystercard.balance).to eq cash
      end
    end
  end
end
