require "oystercard"

describe Oystercard do
  subject(:oystercard) {described_class.new}
  start = Oystercard::DEFAULT_BALANCE
  cash = 5

  context 'Money' do
    it {is_expected.to respond_to(:balance)}
    describe '#balance' do
      it 'Has a default balance of 0' do
        expect(oystercard.balance).to eq start
      end

      it 'Can have money added to it' do
        oystercard.add(cash)
        expect(oystercard.balance).to eq cash
      end
    end
  end
end
