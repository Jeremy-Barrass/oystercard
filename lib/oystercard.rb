class Oystercard
  DEFAULT_BALANCE = 0
  MAX_LIMIT = 90
  MIN_FARE = 1
  @@message = "Unable to complete action: "

  attr_reader :balance, :starting_station, :exit_station, :hist

  def initialize(balance = Oystercard::DEFAULT_BALANCE)
    @balance = balance
    @in_journey = false
    @hist = []
  end

  def top_up(money)
    raise @@message + "too much money" if balance + money > MAX_LIMIT
    @balance += money
  end

  def touch_in(station)
    fail @@message + "insufficient balance" if @balance < MIN_FARE
    @starting_station = station
    @exit_station = nil
  end

  def in_journey?
    !@starting_station.nil?
  end

  def touch_out(station)
    deduct_fare(MIN_FARE)
    @exit_station = station
    log_journey
    @starting_station = nil
  end

  private

  def deduct_fare(fare)
    @balance -= fare
  end

  def log_journey
    hist << {starting_station => exit_station}
  end
end
