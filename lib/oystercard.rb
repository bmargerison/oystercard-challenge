class Oystercard
attr_reader :balance

ACCOUNT_LIMIT = 90.00

def initialize
  @balance = 0
end

def top_up(deposit)
    raise "balance exceeded #{ACCOUNT_LIMIT}" if (@balance + deposit).to_f > ACCOUNT_LIMIT
    @balance += deposit
  
end
  
end