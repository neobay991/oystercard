class OysterCard

  DEFAULT_BALANCE = 0

  attr_reader :balance

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
  end

  def top_up(number)
    fail "Max amount exceeded" if (@balance + number) > 90
    @balance += number
  end

end
