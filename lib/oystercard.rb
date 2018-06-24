require_relative './station.rb'
require_relative './journey.rb'
require_relative './station.rb'

class OysterCard

  DEFAULT_BALANCE = 0
  MAX_BALANCE = 90
  MIN_AMOUNT = 1
  PENALTY_AMOUNT = 6

  attr_reader :balance, :card_touch_in, :card_touch_out, :journey,
              :entry_station, :fare_amount

  def initialize(balance = DEFAULT_BALANCE)
    # @in_journey = false
    @balance = balance
    @card_touch_in = false
    @card_touch_out = false
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
    @card_touch_in = true
  end

  def touch_out(station)
    journey.end_journey(station)
    journey.add_journey_entry
    @card_touch_out = true
    fare
  end

  def fare
    if @card_touch_in == true && @card_touch_out == true
      if journey.exit_station_zone == journey.entry_station_zone
        @fare_amount = MIN_AMOUNT
      elsif journey.exit_station_zone > journey.entry_station_zone
        @fare_amount = MIN_AMOUNT + (journey.exit_station_zone - journey.entry_station_zone)
      elsif journey.entry_station_zone > journey.exit_station_zone
        @fare_amount = MIN_AMOUNT + (journey.entry_station_zone - journey.exit_station_zone)
      end
    else
      @fare_amount = PENALTY_AMOUNT
    end
    reset_touch_in
    reset_touch_out
    deduct(@fare_amount)
  end

  private

  def deduct(number)
    @balance -= number
  end

  def reset_touch_in
    card_touch_in = false
  end

  def reset_touch_out
    card_touch_out = false
  end

end
