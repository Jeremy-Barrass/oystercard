class Oystercard
  DEFAULT_BALANCE = 0
  MAX_LIMIT = 90
  @@message = "Unable to complete action: "

  attr_reader :balance, :starting_station, :exit_station, :hist

  def initialize(balance = Oystercard::DEFAULT_BALANCE)
    @balance = balance
    @hist = []
  end

  def top_up(money)
    raise @@message + "too much money" if balance + money > MAX_LIMIT
    @balance += money
  end

  def touch_in(station, journey=Journey.new)
    fail @@message + "insufficient balance" if @balance < Journey::MIN_FARE
    @journey = journey
    @journey.journey_start station
  end

  def touch_out(station)
    @journey.journey_end station
    deduct_fare(@journey.calculate_fare)
    log_journey
  end

  private

  def deduct_fare(fare)
    @balance -= fare
  end

  def log_journey
    hist << @journey.current_journey
  end
end
