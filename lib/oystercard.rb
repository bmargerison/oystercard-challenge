class Oystercard
  attr_reader :balance, :entry_station

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
    !!@entry_station
  end

  def touch_in(station)
    fail "insufficient funds" if @balance < MINIMUM_FARE
    @entry_station = station
  end

  def touch_out
    @balance -= MINIMUM_FARE
    @entry_station = nil
  end

end