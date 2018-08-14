# oystercard
==================

What is working:
-------
All of the following features listed below have been implemented.

Features implemented
-------
```
In order to use public transport
As a customer
I want money on my card

In order to keep using public transport
As a customer
I want to add money to my card

In order to protect my money
As a customer
I don't want to put too much money on my card

In order to pay for my journey
As a customer
I need my fare deducted from my card

In order to get through the barriers
As a customer
I need to touch in and out

In order to pay for my journey
As a customer
I need to have the minimum amount for a single journey

In order to pay for my journey
As a customer
I need to pay for my journey when it's complete

In order to pay for my journey
As a customer
I need to know where I've travelled from

In order to know where I have been
As a customer
I want to see to all my previous trips

In order to know how far I have travelled
As a customer
I want to know what zone a station is in

In order to be charged correctly
As a customer
I need a penalty charge deducted if I fail to touch in or out

In order to be charged the correct amount
As a customer
I need to have the correct fare calculated

```

Features/ Enhancements not implemented
-------
```
* Extracting methods for starting a journey, ending a journey and returning a
list of journeys into its own class

```

Tech stack
-------
* Ruby app
* RSpec test framework used for running tests


Instructions to Start
-------
* Clone the repo
* Open IRB and type in 'require './lib/oystercard.rb''

IRB commands:
* oystercard = OysterCard.new - to create a new Oystercard object
* oystercard.top_up(amount) - top up account e.g. oystercard.top_up(10)
* station1 = Station.new(station, zone) - create a Station object e.g. station1 = Station.new("Liverpool Street", 1)
* station2 = Station.new(station, zone) - create a Station object e.g. station1 = Station.new("Stratford", 3)
* oystercard.touch_in(station) - touch in to start a journey e.g. oystercard.touch_in(station1)
* oystercard.touch_out(station) - touch out to end a journey e.g. oystercard.touch_out(station2)
