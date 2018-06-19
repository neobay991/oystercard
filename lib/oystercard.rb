class OysterCard

  DEFAULT_BALANCE = 0
  MIN_BALANCE = 1
  MAX_BALANCE = 90


  attr_reader :balance
  attr_accessor :in_journey

  def initialize(balance = DEFAULT_BALANCE)
    @in_journey = false
    @balance = balance
  end

  def top_up(number)
    fail "Maximum balance of #{MAX_BALANCE} exceeded" if (@balance + number) > MAX_BALANCE
    @balance += number
  end

  def deduct(number)
    @balance -= number
  end

  def touch_in
    fail "cannot touch in, balance is below minimum" if @balance < MIN_BALANCE
    @in_journey = true
  end

  def touch_out
    @in_journey = false
  end

  def in_journey?
    @in_journey
  end

end
