require 'oystercard'

describe Oystercard do
    it 'checks balance is 0 by default' do
        newcard = Oystercard.new
        expect(newcard.balance).to eq 0
    end

    it 'adds top-up amount to balance' do
        newcard = Oystercard.new
        newcard.top_up(50.00)
        expect(newcard.balance).to eq 50.00
    end

    it 'throws error if card limit exceeded' do
        maximum_balance = Oystercard::ACCOUNT_LIMIT
        subject.top_up(maximum_balance)
        expect{subject.top_up 1 }.to raise_error(RuntimeError)
    end
    
    it 'deducts money when spent' do
        subject.top_up(60)
        subject.spend(50)
        expect(subject.balance).to eq 10
    end
    
end