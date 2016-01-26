class Journey
  attr_reader :starting_station, :exit_station, :current_journey
  PENALTY_FARE = 6
  MIN_FARE = 1

  def journey_start station
    @starting_station = station
    @exit_station = nil
  end

  def journey_end station
    @exit_station = station
    @current_journey = {starting_station => exit_station}
  end

  def calculate_fare
    return PENALTY_FARE if @starting_station.nil? || @exit_station.nil?
    if starting_station.zone > exit_station.zone
      fare = starting_station.zone - exit_station.zone + MIN_FARE
    else
      fare = exit_station.zone - starting_station.zone + MIN_FARE
    end
    @starting_station = nil
    fare
  end

end
