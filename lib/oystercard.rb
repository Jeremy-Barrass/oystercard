class Oystercard
  DEFAULT_BALANCE = 0
  MAX_LIMIT = 90
  MIN_FARE = 1
  @message = "Unable to complete action: "

  attr_reader :balance

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
    @in_journey = false
  end

  def top_up(money)
    raise @message + "too much money" if balance + money > MAX_LIMIT
    @balance += money
  end

  def touch_in
    fail @message + "insufficient balance" if @balance < MIN_FARE
    @in_journey = true
  end

  def in_journey?
    @in_journey
  end

  def touch_out
    @in_journey = false
    deduct_fare(MIN_FARE)
  end

  private

  def deduct_fare(fare)
    @balance -= fare
  end
end
