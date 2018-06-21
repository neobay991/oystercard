require_relative './station.rb'

class OysterCard

  DEFAULT_BALANCE = 0
  MIN_AMOUNT = 1
  MAX_BALANCE = 90

  attr_reader :balance, :entry_station, :entry_station_zone, :exit_station, :exit_station_zone, :journey_history
  # attr_accessor :in_journey

  def initialize(balance = DEFAULT_BALANCE)
    #@in_journey = false
    @balance = balance
    @journey_history = []
  end

  def top_up(number)
    fail "Maximum balance of #{MAX_BALANCE} exceeded" if (balance + number) > MAX_BALANCE
    @balance += number
  end

  def touch_in(station)
    fail "cannot touch in, balance is below minimum amount" if balance < MIN_AMOUNT
    @entry_station = station.name
    @entry_station_zone = station.zone
    #@in_journey = true

  end

  def touch_out(station)
    deduct(MIN_AMOUNT)
    @exit_station = station.name
    @exit_station_zone = station.zone
    add_journey_history
    @entry_station = nil
    @entry_station_zone = nil
    #@in_journey = false
  end

  def add_journey_history
    @journey_history << { :entry_s => @entry_station, :entry_s_zone => @entry_station_zone, :exit_s => @exit_station, :exit_s_zone => @exit_station_zone }
  end

  def in_journey?
    #check if there is an entry_station returned
    !!entry_station
  end

  # private

  def deduct(number)
    @balance -= number
  end

end
