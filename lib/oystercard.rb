class OysterCard

  DEFAULT_BALANCE = 0
  MIN_AMOUNT = 1
  MAX_BALANCE = 90

  attr_reader :balance, :entry_station, :exit_station, :journey_history
  attr_accessor :in_journey

  def initialize(balance = DEFAULT_BALANCE)
    @in_journey = false
    @balance = balance
    @journey_history = []
  end

  def top_up(number)
    fail "Maximum balance of #{MAX_BALANCE} exceeded" if (@balance + number) > MAX_BALANCE
    @balance += number
  end

  def touch_in(entry_station)
    fail "cannot touch in, balance is below minimum amount" if @balance < MIN_AMOUNT
    @entry_station = entry_station
    @in_journey = true

  end

  def touch_out(exit_station)
    deduct(MIN_AMOUNT)
    @exit_station = exit_station
    journey_history
    @entry_station = nil
    @in_journey = false

  end

  def journey_history
    @journey_history << { :entry => @entry_station, :exit => @exit_station }
  end

  def in_journey?
    @in_journey
  end

  # private

  def deduct(number)
    @balance -= number
  end

end
