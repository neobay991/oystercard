require_relative './oystercard.rb'

# should be responsible for starting a journey, finishing a journey, calculating the fare of a journey, and returning whether or not the journey is complete.

class Journey

  attr_reader :entry_station, :entry_station_zone, :exit_station, :exit_station_zone, :journey_history

  def initialize
    @journey_history = []
  end

  def start_journey(station)
    @entry_station = station.name
    @entry_station_zone = station.zone
  end

  def end_journey(station)
    @exit_station = station.name
    @exit_station_zone = station.zone
  end

  def add_journey_entry
    @journey_history << { :entry_s => @entry_station, :entry_s_zone => @entry_station_zone, :exit_s => @exit_station, :exit_s_zone => @exit_station_zone }
  end

  def in_journey?
    #check if there is an entry_station returned
    !!entry_station
  end

end
