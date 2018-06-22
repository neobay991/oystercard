require_relative './station.rb'
require_relative './journey.rb'
require_relative './station.rb'

class OysterCard

  DEFAULT_BALANCE = 0
  MAX_BALANCE = 90
  MIN_AMOUNT = 1
  PENALTY_AMOUNT = 6

  attr_reader :balance, :touch_in, :touch_out, :journey, :entry_station, :fare_amount
  # attr_accessor :in_journey

  def initialize(balance = DEFAULT_BALANCE)
    # @in_journey = false
    @balance = balance
    @touch_in = false
    @touch_out = false
    # @journey_history = []
    @journey = Journey.new
  end

  def top_up(number)
    fail "Maximum balance of #{MAX_BALANCE} exceeded" if (balance + number) > MAX_BALANCE
    @balance += number
  end

  def touch_in(station)
    fail "cannot touch in, balance is below minimum amount" if balance < MIN_AMOUNT
    journey.start_journey(station)
    @touch_in = true

    # @entry_station = station.name
    # @entry_station_zone = station.zone
    # @in_journey = true
  end

  def touch_out(station)
    journey.end_journey(station)
    journey.add_journey_entry
    @touch_out = true
    fare
    #deduct(MIN_AMOUNT)
    #exit_station = station.name
    # @exit_station_zone = station.zone
    # entry_station = nil
    # @entry_station_zone = nil
    # @in_journey = false
  end

  # def add_journey_history
  # #@journey_history << { :entry_s => @entry_station, :entry_s_zone => @entry_station_zone, :exit_s => @exit_station, :exit_s_zone => @exit_station_zone }
  # end

  # def in_journey?
  #   journey.in_journey?
  #   #check if there is an entry_station returned
  #   #!!entry_station
  # end

  def fare
    if @touch_in == true && @touch_out == true
      if journey.exit_station_zone == journey.entry_station_zone
        @fare_amount = MIN_AMOUNT
      elsif journey.exit_station_zone > journey.entry_station_zone
        @fare_amount = MIN_AMOUNT + (journey.exit_station_zone - journey.entry_station_zone)
      elsif journey.entry_station_zone > journey.exit_station_zone
        @fare_amount = MIN_AMOUNT + (journey.entry_station_zone - journey.exit_station_zone)
      end
    else
      @fare_amount  = PENALTY_AMOUNT
    end
    reset_touch_in
    reset_touch_out
    deduct(@fare_amount)
  end

  # def fare_lookup
  #   if journey.exit_station_zone == journey.entry_station_zone
  #     @fare_amount = MIN_AMOUNT
  #   elsif journey.exit_station_zone > journey.entry_station_zone
  #     @fare_amount = MIN_AMOUNT + (journey.exit_station_zone - journey.entry_station_zone)
  #   elsif journey.entry_station_zone > journey.exit_station_zone
  #     @fare_amount = MIN_AMOUNT + (journey.entry_station_zone - journey.exit_station_zone)
  #   end
  # end

  private

  def deduct(number)
    @balance -= number
  end

  def reset_touch_in
    touch_in = false
  end

  def reset_touch_out
    touch_out = false
  end

end
