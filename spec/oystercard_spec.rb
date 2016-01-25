require "oystercard"

describe Oystercard do
  subject(:oystercard) {described_class.new}
  starting_balance = Oystercard::DEFAULT_BALANCE

  it {is_expected.to respond_to(:balance)}
  describe '#balance' do
    it 'Has a default balance of 0' do
      expect(oystercard.balance).to eq starting_balance
    end
  end
end
