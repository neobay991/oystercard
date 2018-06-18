class OysterCard

  DEFAULT_BALANCE = 0
  MAX_BALANCE = 90

  attr_reader :balance

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
  end

  def top_up(number)
    fail "Maximum balance of #{MAX_BALANCE} exceeded" if (@balance + number) > MAX_BALANCE
    @balance += number
  end

  def deduct(number)
    @balance -= number
  end

  def in_journey?
    @in_journey = false
  end
end
