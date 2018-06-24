require_relative './oystercard.rb'
require_relative './station.rb'

class Journey

  attr_reader :journey_history, :in_journey, :journey_complete, :entry_station,
  :entry_station_zone, :exit_station, :exit_station_zone

  def initialize
    @journey_history = []
    @in_journey = false
    @journey_complete = false
  end

  def start_journey(station)
    @entry_station = station.name
    @entry_station_zone = station.zone
    @in_journey = true
    @journey_complete = false
  end

  def end_journey(station)
    @exit_station = station.name
    @exit_station_zone = station.zone
    @in_journey = false
    @journey_complete = true
  end

  def add_journey_entry
    if journey_complete == true && in_journey == false
      journey_history << { :entry_s => entry_station,
        :entry_s_zone => entry_station_zone, :exit_s => exit_station,
        :exit_s_zone => exit_station_zone }

      reset_journey
    end
  end

  def in_journey?
    # check if in journey
    !!in_journey
  end

  def journey_complete?
    # check if journey complete
    !!journey_complete
  end

  private

  def reset_journey
    entry_station = nil
    entry_station_zone = nil
    exit_station = nil
    exit_station_zone = nil
  end
end
