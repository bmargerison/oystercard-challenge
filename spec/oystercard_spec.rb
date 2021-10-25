require 'oystercard'

describe Oystercard do
    it 'checks balance is 0 by default' do
        newcard = Oystercard.new
        expect(newcard.balance).to eq 0
    end
    
end