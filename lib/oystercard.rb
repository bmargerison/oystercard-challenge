class Oystercard
  attr_reader :balance

  ACCOUNT_LIMIT = 90.00
  MINIMUM_FARE = 1.00

  def initialize
    @balance = 0
    @travelling = false
  end

  def top_up(deposit)
      
      raise "balance exceeded #{ACCOUNT_LIMIT}" if (@balance + deposit).to_f > ACCOUNT_LIMIT
      @balance += deposit
  end

  def spend(amount)
    @balance -= amount
  end

  def in_journey?
    @travelling
  end

  def touch_in
    fail "insufficient funds" if @balance < MINIMUM_FARE
    @travelling = true
  end

  def touch_out
    @balance -= MINIMUM_FARE
    @travelling = false
  end

end