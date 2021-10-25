require 'oystercard'

describe Oystercard do
    it 'checks balance is 0 by default' do
        newcard = Oystercard.new
        expect(newcard.balance).to eq 0
    end

    it 'adds top-up amount to balance' do
        subject.top_up(50.00)
        expect(subject.balance).to eq 50.00
    end
    
end